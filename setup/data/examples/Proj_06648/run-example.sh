#!/bin/bash

prism_request_to_yaml.py \
	-m Proj_06648_sample_mapping.txt \
	-p Proj_06648_sample_pairing.txt \
	-g Proj_06648_sample_grouping.txt \
	-o . \
	-f inputs.yaml

nohup prism-runner.sh \
	-w project-workflow.cwl \
	-i inputs.yaml \
	-b lsf &

# prism_submit.py \
#     --id Proj_06648 \
#     --path . \
#     --workflow project-workflow.cwl