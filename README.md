

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:ListContainerInstances",
                "ecs:DescribeContainerInstances",
                "ec2:DescribeInstances"
            ],
            "Resource": "*"
        }
    ]
}
