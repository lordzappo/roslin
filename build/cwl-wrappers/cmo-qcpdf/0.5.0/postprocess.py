#!/usr/bin/python
"""postprocess"""

import argparse
import ruamel.yaml


def read(filename):
    """return file contents"""

    with open(filename, 'r') as file_in:
        return file_in.read()


def write(filename, cwl):
    """write to file"""

    with open(filename, 'w') as file_out:
        file_out.write(cwl)


def main():
    """main function"""

    parser = argparse.ArgumentParser(description='postprocess')

    parser.add_argument(
        '-f',
        action="store",
        dest="filename_cwl",
        help='Name of the cwl file',
        required=True
    )

    params = parser.parse_args()

    cwl = ruamel.yaml.load(read(params.filename_cwl),
                           ruamel.yaml.RoundTripLoader)

    cwl['inputs']['gcbias_files']['type'] = ruamel.yaml.load("""
type: array
items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['mdmetrics_files']['type'] = ruamel.yaml.load("""
type: array
items:
  type: array
  items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['insertsize_files']['type'] = ruamel.yaml.load("""
type: array
items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['hsmetrics_files']['type'] = ruamel.yaml.load("""
type: array
items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['qualmetrics_files']['type'] = ruamel.yaml.load("""
type: array
items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['fingerprint_files']['type'] = ruamel.yaml.load("""
type: array
items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['trimgalore_files']['type'] = ruamel.yaml.load("""
- type: array
  items:
    type: array
    items:
      type: array
      items:
        type: array
        items: File
""", ruamel.yaml.RoundTripLoader)

    cwl['inputs']['fp_genotypes']['type'] = 'File'
    cwl['inputs']['pairing_file']['type'] = 'File'
    cwl['inputs']['grouping_file']['type'] = 'File'
    cwl['inputs']['request_file']['type'] = 'File'

    #-->
    # fixme: until we can auto generate cwl for cmo-qcpdf
    # set outputs using outputs.yaml
    import os
    cwl['outputs'] = ruamel.yaml.load(
        read(os.path.dirname(params.filename_cwl) + "/outputs.yaml"),
        ruamel.yaml.RoundTripLoader)['outputs']
    #<--

    write(params.filename_cwl, ruamel.yaml.dump(
        cwl, Dumper=ruamel.yaml.RoundTripDumper))


if __name__ == "__main__":

    main()