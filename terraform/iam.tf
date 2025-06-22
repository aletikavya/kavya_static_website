# CodeBuild Role: Allows build project to upload artifacts to S3
resource "aws_iam_role" "codebuild_role" {
  name = "kavya-codebuild-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "codebuild.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# CodePipeline Role: Grants pipeline access to services it interacts with
resource "aws_iam_role" "codepipeline_role" {
  name = "kavya-codepipeline-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "codepipeline.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach only required managed policies to CodePipeline role
resource "aws_iam_role_policy_attachment" "codepipeline_codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_s3_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_codebuild_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_cloudwatch_logs_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
