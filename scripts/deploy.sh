#!/bin/bash
source env.sh

stack_name=finding-vpce-blog
template_file=vpc-endpoint-opportunities-new-vpc-cloud9.yaml
template_bucket=group4-pca-cfn
usage="Usage: deploy.sh <delete> | <create> | <update>"

# exit if no parameter specified
if [[ -z $1 ]]; then
    echo $usage
    exit
fi

if [[ $1 == "delete" ]]; then
    aws cloudformation delete-stack --region ${aws_region} --stack-name ${stack_name}
    exit
fi

validate.sh ../${template_file}

# Copy template to S3
aws s3 cp ../${template_file} s3://${template_bucket}/

if [[ $1 == "create" ]]; then
    aws cloudformation deploy --region ${aws_region} \
        --template-file ../${template_file} \
        --stack-name ${stack_name} \
        --capabilities CAPABILITY_IAM --no-cli-pager
else
    if [[ $1 == "update" ]]; then
        echo "https://${template_bucket}.s3.amazonaws.com/${template_file}"
        aws cloudformation update-stack --region ${aws_region} \
            --template-url "https://${template_bucket}.s3.amazonaws.com/${template_file}" \
            --stack-name ${stack_name} \
            --capabilities CAPABILITY_NAMED_IAM --no-cli-pager
    else
        echo $usage
    fi
fi