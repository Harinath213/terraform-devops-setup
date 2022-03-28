resource "aws_iam_role_policy" "ec2-policy" {
  name = "ec2-policy"
  role = aws_iam_role.ec2-app.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket",
                "s3:PutObjectAcl"
            ],
            "Resource": "*"
        },
        {
             "Effect": "Allow",
             "Action": "sts:AssumeRole",
             "Resource": "*"
        },
        {
             "Effect": "Allow",
             "Action": "ec2:Describe*",
             "Resource": "*"
        }
    ]
 }
 EOF  
}

resource "aws_iam_role" "ec2-app" {
  name = "ec2-app"

  assume_role_policy = <<EOF

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
              "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
 }
 EOF
}

resource "aws_iam_role_policy_attachment" "ssm-ec2" {
    role = aws_iam_role.ec2-app.id
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  
}

resource "aws_iam_instance_profile" "ec2-app" {
    name = "ec2-app"
    role = aws_iam_role.ec2-app.id
  
}