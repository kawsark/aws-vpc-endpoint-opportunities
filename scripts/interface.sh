#!/bin/bash
source env.sh

template_file=../interface_endpoint_example.yaml
endpoint_service_name=ssm
stack_name="vpc-endpoint-${endpoint_service_name}"

if [[ $1 == "delete" ]]; then
    aws cloudformation delete-stack --region ${aws_region} --stack-name ${stack_name}
    exit
fi

validate.sh $template_file

aws cloudformation deploy --region ${aws_region} \
    --template-file ${template_file} \
    --stack-name ${stack_name} \
    --parameter-overrides VPCID=${vpc_id} \
    VPCSubnetIDs=${subnet_ids} \
    ServiceParam=${endpoint_service_name}

