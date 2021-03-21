# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates the EC2 instances EBS Volume in the AWS region of your choice.
# Check the Terraform docs for any major changes to the arguments and requirement.
# https://www.terraform.io/docs/providers/aws/d/ebs_volume.html
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_ebs_volume" "volume" {
  count = var.instance_count

  # -- required arguments for the resource
  availability_zone = legnth(var.instance_count) > 0 ? element(var.availability_zone, count.index) : var.availability_zone

  # -- optional argument for the resource
  encrypted   = var.encrypted
  iops        = if(var.type) == "gp2" : var.iops
  kms_key_id  = var.kms_key_id
  size        = var.size
  snapshot_id = var.snapshot_id
  type        = var.type

  # -- tags for the volume
  tags = merge(
    {
      
    },
    var.tags,
  )
}
