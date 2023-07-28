#!/bin/bash
source env.sh

template_file=../gateway-endpoint.yaml
endpoint_service_name=s3
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
    ServiceParam=${endpoint_service_name} \
    RouteTableIDs=${route_table_ids}
