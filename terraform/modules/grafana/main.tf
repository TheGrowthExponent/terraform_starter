resource "aws_grafana_workspace" "obs_platform" {
  name                     = "${var.application_name}-${var.environment}"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                 = var.grafana_role_arn
  configuration = jsonencode({
    "plugins" : {
      "pluginAdminEnabled" : true
    },
    "unifiedAlerting" : {
      "enabled" : true
    }
  })
  data_sources    = ["AMAZON_OPENSEARCH_SERVICE", "ATHENA", "CLOUDWATCH", "PROMETHEUS", "REDSHIFT", "SITEWISE", "TIMESTREAM", "XRAY"]
  grafana_version = "10.4"
  # notification_destinations = "SNS"
  # vpc_configuration = {
  #   security_group_ids = var.sg_ids,
  #   subnet_ids         = var.subnet_ids
  # }
}

resource "aws_grafana_workspace_api_key" "obs_platform_admin_key" {
  key_name        = "obs-platform-admin-key"
  key_role        = "ADMIN"
  seconds_to_live = 3600
  workspace_id    = aws_grafana_workspace.obs_platform.id
}

# resource "aws_grafana_workspace_service_account" "obs_platform_admin" {
#   name         = "admin-service-account"
#   grafana_role = "ADMIN"
#   workspace_id = aws_grafana_workspace.obs_platform.id
# }
#
# resource "aws_grafana_workspace_service_account_token" "obs_platform_admin_token" {
#   name               = "admin-service-account-key"
#   service_account_id = aws_grafana_workspace_service_account.obs_platform_admin.service_account_id
#   seconds_to_live    = 3600
#   workspace_id       = aws_grafana_workspace.obs_platform.id
# }

resource "grafana_folder" "my_test_folder" {
  title = "Test Folder"
}

resource "grafana_dashboard" "test_folder" {
  folder = grafana_folder.my_test_folder.id
  config_json = jsonencode({
    "title" : "My Dashboard Title",
    "uid" : "my-dashboard-uid"
    // ... other dashboard properties
  })
}
