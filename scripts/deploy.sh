#!/bin/bash
source env.sh

stack_name=finding-vpce-blog
template_file=../vpc-endpoint-opportunities-new-vpc-cloud9.yaml

if [[ $1 == "delete" ]]; then
    aws cloudformation delete-stack --region ${aws_region} --stack-name ${stack_name}
    exit
fi

validate.sh ${template_file}

aws cloudformation deploy --region ${aws_region} \
    --template-file ${template_file} \
    --stack-name ${stack_name} \
    --capabilities CAPABILITY_IAM
