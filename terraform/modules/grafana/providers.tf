provider "grafana" {
  url  = "https://${aws_grafana_workspace.obs_platform.endpoint}"
  auth = aws_grafana_workspace_api_key.obs_platform_admin_key.key
}
