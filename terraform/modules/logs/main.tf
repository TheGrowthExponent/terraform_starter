resource "aws_cloudwatch_log_group" "log_group" {
  name = "app-${var.application_name}-${var.environment}"
}

# resource "aws_cloudwatch_dashboard" "main" {
#   dashboard_name = "app-${var.application_name}-${var.environment}"
#
#   dashboard_body = <<EOF
# {
#   "widgets": [
#     {
#       "type": "metric",
#       "x": 0,
#       "y": 0,
#       "width": 12,
#       "height": 6,
#       "properties": {
#         "metrics": [
#           [
#             "AWS/EC2",
#             "CPUUtilization",
#             "InstanceId",
#             "i-012345"
#           ]
#         ],
#         "period": 300,
#         "stat": "Average",
#         "region": ${var.region},
#         "title": "EC2 Instance CPU"
#       }
#     },
#     {
#       "type": "text",
#       "x": 0,
#       "y": 7,
#       "width": 3,
#       "height": 3,
#       "properties": {
#         "markdown": "Hello world"
#       }
#     }
#   ]
# }
# EOF
# }

resource "aws_cloudwatch_dashboard" "main" {
  count          = var.create_aws_cloudwatch_dashboard ? 1 : 0
  dashboard_name = "app-${var.application_name}-${var.environment}"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    }
  ]
}
EOF
}
