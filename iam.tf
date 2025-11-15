resource "aws_iam_role" "lambda-role" {
  path                 = "/"
  name                 = "bun-lambda-role"
  assume_role_policy   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  max_session_duration = 3600
}

resource "aws_iam_role_policy" "IAMPolicy3" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
         {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:*",
                "logs:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  role   = aws_iam_role.lambda-role.name
}