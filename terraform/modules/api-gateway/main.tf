#data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api" "api" {
  name = "app-apigw-${var.application_name}-${var.environment}"
  endpoint_configuration {
    types = [var.api_gw_endpoint_configuration_type]
  }
}

#resource "aws_api_gateway_authorizer" "apigw_authorizer" {
#  name                   = "app-apigw_authorizer-${var.application_name}-${var.environment}"
#  rest_api_id            = aws_api_gateway_rest_api.api.id
#  authorizer_uri         = var.lambda_authorizer.invoke_arn
#  authorizer_credentials = var.apigw_role.arn
#}

resource "aws_api_gateway_resource" "api_resource" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "api"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_domain_name" "api" {
  domain_name              = "api.${var.host_name}.${data.aws_route53_zone.selected.name}"
  regional_certificate_arn = var.certificate.arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id        = aws_api_gateway_deployment.api.id
  rest_api_id          = aws_api_gateway_rest_api.api.id
  stage_name           = "${var.application_name}-${var.environment}"
  xray_tracing_enabled = true
  access_log_settings {
    destination_arn = "arn:aws:logs:ap-southeast-2:${var.account_id}:log-group:/aws/api_gw/app-apigw-${var.application_name}-${var.environment}"
    format          = "$context.identity.sourceIp $context.identity.caller $context.identity.user [$context.requestTime] \"$context.httpMethod $context.resourcePath $context.protocol\" $context.status $context.responseLength $context.requestId"
  }
}

resource "aws_api_gateway_base_path_mapping" "stage" {
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = "${var.application_name}-${var.environment}"
  domain_name = aws_api_gateway_domain_name.api.domain_name
  base_path   = "api"
}

resource "aws_api_gateway_api_key" "apikey" {
  name = "${var.application_name}-${var.environment}"
}

resource "aws_route53_record" "record" {
  name    = "api.${var.host_name}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id

  alias {
    name                   = aws_api_gateway_domain_name.api.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api.regional_zone_id
    evaluate_target_health = false
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api_gw/${aws_api_gateway_rest_api.api.name}"
  retention_in_days = 30
}

resource "aws_api_gateway_usage_plan" "api" {
  name        = "api.plan.${var.host_name}.${data.aws_route53_zone.selected.name}"
  description = "API Usage Plan"
  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = "${var.application_name}-${var.environment}"
  }
  quota_settings {
    limit  = 1000
    offset = 2
    period = "WEEK"
  }
  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

resource "aws_api_gateway_usage_plan_key" "api" {
  key_id        = aws_api_gateway_api_key.apikey.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api.id
}
