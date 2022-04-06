output "webservers_ip_addresses_output"{
  value = aws_instance.devops106_terraform_group4_deren_webserver_app_tf[*].public_ip
}
