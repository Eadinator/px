resource "aws_codestarconnections_connection" "px" {
  name          = "px"
  provider_type = var.px.provider
}

resource "aws_codepipeline" "px" {
  name     = "px"
  role_arn = aws_iam_role.px.arn

  artifact_store {
    location = aws_s3_bucket.px.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      configuration = {
        "ConnectionArn"        = aws_codestarconnections_connection.px.arn
        "FullRepositoryId"     = var.px.repo
        "BranchName"           = var.px.branch
        "OutputArtifactFormat" = "CODE_ZIP"
      }
      output_artifacts = [
        "SourceArtifact",
      ]
      version = "1"
    }
  }
  stage {
    name = "Deploy"
    action {
      name     = "Deploy"
      category = "Deploy"
      owner    = "AWS"
      provider = "ElasticBeanstalk"
      input_artifacts = [
        "SourceArtifact",
      ]
      configuration = {
        "ApplicationName" = "px"
        "EnvironmentName" = "pxenv"
      }
      version = "1"
    }
  }
}
