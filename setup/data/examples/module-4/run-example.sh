#!/bin/bash

workflow="module-4.cwl"

if [ "$1" = "-s" ]
then
    prism_submit.py \
        --id Proj_DEV_`whoami` \
        --path . \
        --workflow ${workflow}
else
    prism-runner.sh \
        -w ${workflow} \
        -i inputs.yaml \
        -b lsf
fi
