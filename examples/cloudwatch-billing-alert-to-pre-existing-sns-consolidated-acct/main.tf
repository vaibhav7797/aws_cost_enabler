provider "aws" {
   region  = "eu-west-1"
}

module "sns" {
  source = "clouddrove/sns/aws"

  name         = "sns"
  environment  = "test"
  label_order  = ["name", "environment"]
  enable_topic = true

  subscribers = {
    newrelic = {
      protocol                        = "https"
      endpoint                        = ""
      endpoint_auto_confirms          = false
      raw_message_delivery            = false
      filter_policy                   = ""
      delivery_policy                 = ""
      confirmation_timeout_in_minutes = "60"
    },
    sms = {
      protocol                        = "sms"
      endpoint                        = "919921603392"
      endpoint_auto_confirms          = false
      raw_message_delivery            = false
      filter_policy                   = ""
      delivery_policy                 = ""
      confirmation_timeout_in_minutes = "60"
    },

  }
}

module "billing_cloudwatch_alert" {
  source = "../../../terraform-aws-cost-billing-alarm07"

  aws_env                   = var.aws_profile
  monthly_billing_threshold = 500
  currency                  = "USD"
  aws_sns_topic_arn         = ["arn:aws:lambda:us-east-1:111111111111:function:bb-root-org-notify_slack"]
}