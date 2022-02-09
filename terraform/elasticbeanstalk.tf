resource "aws_elastic_beanstalk_application" "px" {
  name = "px"
}

resource "aws_elastic_beanstalk_environment" "px" {
  name                = "pxenv"
  application         = aws_elastic_beanstalk_application.px.name
  solution_stack_name = "64bit Amazon Linux 2 v3.3.10 running PHP 8.0"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    name      = "LoadBalancerType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "application"
  }
  setting {
    name      = "document_root"
    namespace = "aws:elasticbeanstalk:container:php:phpini"
    value     = "/deploy"
  }
  setting {
    name      = "DefaultProcess"
    namespace = "aws:elbv2:listener:443"
    value     = "default"
  }
  setting {
    name      = "ListenerEnabled"
    namespace = "aws:elbv2:listener:443"
    value     = "true"
  }
  setting {
    name      = "Protocol"
    namespace = "aws:elbv2:listener:443"
    value     = "HTTPS"
  }
  setting {
    name      = "Rules"
    namespace = "aws:elbv2:listener:443"
    value     = ""
  }
  setting {
    name      = "SSLCertificateArns"
    namespace = "aws:elbv2:listener:443"
    value     = aws_acm_certificate.px.arn
  }
  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    resource  = ""
    value     = "9"
  }
  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    resource  = ""
    value     = "3"
  }
  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    resource  = ""
    value     = "t3a.micro"
  }
  setting {
    name      = "InstanceTypeFamily"
    namespace = "aws:cloudformation:template:parameter"
    resource  = ""
    value     = "t3a"
  }
  setting {
    name      = "InstanceTypes"
    namespace = "aws:ec2:instances"
    resource  = ""
    value     = "t3a.micro"
  }
}
