################ EC2 ################
resource "aws_kms_key" "this" {
}

resource "aws_key_pair" "aws_key" {
  key_name   = "app-${var.application_name}-${var.environment}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDc9vCDIU2sxtYwkhIm+UdAHrYNCpI9spHLcSoCEoNKDaSLDxs7Uxefk2bxZBxJD205Zg5opAXT23gJKkvyK5E+KJG9la34WWQlb6BpWrjomiON9zDn3epthE4J/IpaR4b2yphqd6ucb9QbBrT7fatLf/oNg1MXZsenG0Vizc/6eCprMm2RYa5g72HvrMMFZT0jTE7QoIK/3RFkIWS9sTDbKpFt4jjql2Leu3iaXyALVUF6U5DPFciHGhJy9zsE0tuqj5YqtFKnU12e6rjJihXjEvGeztJvRv8DfVIxrqaFPgG/XicW5qg5nm/pAF820pUX8XG1RK03JCMtL3f5wGKczJXTrFkePA1dkirkY2kdIEsLEVigbIXB0vvkU7QIS+i6ji+B8RxvpXm9qC+GxDoWew9EefMXvSdG/dKw1XD6IdlXgswxSOM0hMhrcSYaae8ukVkwmeTxsSTvdKXvdgdvhsSnGpl78PM0TqRFWeY1APnI1n4LNcI/pq5Gg0OF4vEo admin@server.local"
}
