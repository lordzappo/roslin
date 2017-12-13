#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  doap: http://usefulinc.com/ns/doap#

$schemas:
  - http://dublincore.org/2012/06/14/dcterms.rdf
  - http://xmlns.com/foaf/spec/20140114.rdf
  - http://usefulinc.com/ns/doap#

doap:release:
- class: doap:Version
  doap:name: cmo-bwa-mem
  doap:revision: 0.7.5a
- class: doap:Version
  doap:name: cwl-wrapper
  doap:revision: 1.0.0

dct:creator:
- class: foaf:Organization
  foaf:name: Memorial Sloan Kettering Cancer Center
  foaf:member:
  - class: foaf:Person
    foaf:name: Jaeyoung Chun
    foaf:mbox: mailto:chunj@mskcc.org

dct:contributor:
- class: foaf:Organization
  foaf:name: Memorial Sloan Kettering Cancer Center
  foaf:member:
  - class: foaf:Person
    foaf:name: Jaeyoung Chun
    foaf:mbox: mailto:chunj@mskcc.org

# This tool description was generated automatically by argparse2cwl ver. 0.3.1
# To generate again: $ cmo_bwa_mem -o FILENAME --generate_cwl_tool
# Help: $ cmo_bwa_mem  --help_arg2cwl

cwlVersion: "cwl:v1.0"

class: CommandLineTool
baseCommand: ['cmo_bwa_mem']

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    ramMin: 30
    coresMin: 4


doc: |
  run bwa mem

inputs:
  
  genome:
    type:
      type: enum
      symbols: ['GRCm38', 'hg19', 'ncbi36', 'mm9', 'GRCh37', 'mm10', 'hg18', 'GRCh38']

    inputBinding:
      prefix: --genome 

  fastq1:
    type: string


    inputBinding:
      prefix: --fastq1 

  fastq2:
    type: ["null", string]

    inputBinding:
      prefix: --fastq2 

  output:
    type: string


    inputBinding:
      prefix: --output 

  sam:
    type: ["null", boolean]
    default: False
    doc: Produce Sam instead of the default bam (Boolean)
    inputBinding:
      prefix: --sam 

  version:
    type:
      type: enum
      symbols: ['default']

    inputBinding:
      prefix: --version 


outputs:
  bam:
    type: File
    outputBinding:
      glob: |
        ${
          if (inputs.output)
            return inputs.output;
          return null;
        }