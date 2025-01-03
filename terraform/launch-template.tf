resource "aws_launch_template" "launch_template" {
  name_prefix            = "${var.name}-launch-template"
  image_id               = data.aws_ami.ami.id
  instance_type          = var.backend_instance_type
  vpc_security_group_ids = [aws_security_group.backend_sg.id, aws_security_group.syslog_data.id]
  # Dynamically generate user_data with environment variables
  user_data = base64encode(
    templatefile(
      "./app/user_data/app-startup.sh.tpl",
      {
        db_host     = module.osaka_database.rw_endpoint, # Replace with correct module output
        db_user     = var.db_user,                      # Use variables for credentials
        db_password = var.db_password,                  # Pass securely
        db_name     = "user_db"                     # Use variable for DB name
      }
    )
  )

  tags = {
    Name = "${var.name}-instance"
  }
}