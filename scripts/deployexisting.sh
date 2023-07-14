#!/bin/bash
source env.sh

stack_name=vpc-endpoint-opportunities-existing
template_file=../vpc-endpoint-opportunities-existing-vpc.yaml

if [[ $1 == "delete" ]]; then
    aws cloudformation delete-stack --region ${aws_region} --stack-name ${stack_name}
    exit
fi

validate.sh ${template_file}

aws cloudformation deploy --region ${aws_region} \
    --template-file ${template_file} \
    --stack-name ${stack_name} \
    --parameter-overrides VPCID=${vpc_id}