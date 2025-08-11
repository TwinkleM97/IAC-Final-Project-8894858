# PROG 8870 – Final (Twinkle Mishra – 8894858)

Region: us-east-1. Terraform creates 4 private S3 buckets (versioning on), a custom VPC with EC2, and a private MySQL RDS (MySQL allowed from the EC2 SG).  
CloudFormation creates 3 private S3 buckets (PublicAccessBlock + versioning), an EC2 stack (VPC+IGW+RT+EC2), and a public RDS (for demo only, per spec).

Notes I care about:
- Use SSM parameter for AL2023 AMI (keeps AMI fresh).
- Keep things parameterized; avoid hardcoding.
- Bucket names must be globally unique → suffix helps.

Cleanup: ; delete CFN stacks: cfn-s3-8894858, cfn-ec2-8894858, cfn-rds-8894858
