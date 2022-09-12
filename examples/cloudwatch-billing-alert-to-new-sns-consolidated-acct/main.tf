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
      endpoint                        = "919921xxxxxxx"
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

  environment                  = var.environment
  monthly_billing_threshold = 500
  currency                  = "USD"
}
