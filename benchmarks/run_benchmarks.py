#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import argparse
import os
import json
from datetime import datetime

if __name__ == '__main__':

    # First, let's define a suitable so we can keep benchmarks as time goes on.
    name = "@PROJECT_NAME@_@PROJECT_VERSION@_@CMAKE_BUILD_TYPE@_@CMAKE_CXX_COMPILER_ID@_" + datetime.now().strftime("%Y-%m-%d_%H-%M")
    name = name.lower() + ".json"

    # Now let's parse arguments, default should be good enough
    parser = argparse.ArgumentParser(description='Script to run benchmark with appropriate name.')
    parser.add_argument('-e', '--exe', default='@BENCHMARKS_EXE_NAME@', help='Path to benchmark executable.')
    parser.add_argument('-n', '--name', default=name, help='Name of benchmarks output file.')
    parser.add_argument('-f', '--filter', help='Filter')
    parser.add_argument('-r', '--repetition', help='Repetition')
    args = parser.parse_args()

    # Let's prepare our call to run benchmarks
    array = [args.exe,
        "--benchmark_out=" + args.name,
    ]
    if args.filter:
        array.append("--benchmark_filter=" + args.filter)
    if args.repetition:
        array.append("--benchmark_repetitions=" + args.repetition)
        array.append("--benchmark_report_aggregates_only=true")

    result = subprocess.run(array, shell=True)
    if result.returncode == 0:
        print('\nSuccess !\nResults written to : ' + name)

    # We add several informations to the ouput so we can display more information on our graphs
    with open(name, 'r') as f:
        json_file = json.load(f)
        json_file["context"]["git_tag"] = "@GIT_TAG@"
        json_file["context"]["git_commit"] = "@GIT_COMMIT@"

    with open(name, 'w') as f:
        json.dump(json_file, f, indent=4)