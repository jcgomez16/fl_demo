#!/bin/bash

AWS_REGION="us-west-2"
S3_BUCKET_NAME="labs-cgomez-terraform-state-bucket"
DYNAMODB_TABLE_NAME="terraform-state-lock"
PROFILE="test"

echo "Creating S3 bucket: $S3_BUCKET_NAME"
aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION --profile $PROFILE

echo "Enabling versioning on S3 bucket: $S3_BUCKET_NAME"
aws s3api put-bucket-versioning --bucket $S3_BUCKET_NAME --versioning-configuration Status=Enabled --profile $PROFILE

echo "Creating DynamoDB table: $DYNAMODB_TABLE_NAME"
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $AWS_REGION \
    --profile $PROFILE
