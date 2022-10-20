output "api" {
  value = aws_api_gateway_rest_api.api
}

output "api_gw_api_resource" {
  value = aws_api_gateway_resource.api_resource
}

output "aws_api_gateway_domain_name" {
  value = aws_api_gateway_domain_name.api
}

output "aws_api_gateway_api_key" {
  value = aws_api_gateway_api_key.apikey
}

#output "aws_api_gateway_authorizer" {
#  value = aws_api_gateway_authorizer.apigw_authorizer
#}

