resource "aws_efs_file_system" "efs" {
  tags = merge(
    {
        Name = "${local.naming_prefix}lambda-efs"
    }
  )
}

resource "aws_efs_mount_target" "efs_mount" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id = local.priv_subnet_a
  security_groups = [
    aws_security_group.efs_sg.id
  ]   
}

resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs.id
  
  root_directory {
    path = "/lambda"

    creation_info {
      owner_gid = 1000
      owner_uid = 1000
      permissions = "777"
    }
  }

  posix_user {
    gid = 1000
    uid = 1000
  }
}