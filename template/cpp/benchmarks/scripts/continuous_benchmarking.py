# -*- coding: utf-8 -*-

import subprocess
import argparse
import os, shutil
import json
from datetime import datetime
from typing import List

def create_nested_directories(path: str, dirs: List[str]):
    current_path = path
    for _dir in dirs:
        current_path = os.path.join(current_path, _dir)
        if not os.path.exists(current_path):
            os.mkdir(current_path)
    return current_path


if __name__ == '__main__':

    name = "@GIT_COMMIT@.json"

    parser = argparse.ArgumentParser(description='Script to run benchmark with appropriate name.')
    parser.add_argument('-e', '--exe', default='..\\@BENCHMARKS_EXE_NAME@', help='Path to benchmark executable.')
    parser.add_argument('-n', '--name', default=name, help='Name of benchmarks output file.')
    parser.add_argument('-f', '--filter', help='Filter')
    parser.add_argument('-r', '--repetition', default=10, help='Repetition')
    args = parser.parse_args()

    array = [args.exe, "--benchmark_out=" + args.name]
    if args.filter:
        array.append("--benchmark_filter=" + args.filter)
    if args.repetition:
        array.append("--benchmark_repetitions=" + str(args.repetition))
        array.append("--benchmark_report_aggregates_only=true")

    result = subprocess.run(array, shell=True)
    if result.returncode == 0:
        path = create_nested_directories("@BENCHMARKS_OUTPUT_DIR@", ["@CMAKE_BUILD_TYPE@", "@CMAKE_CXX_COMPILER_ID@"])
        location = os.path.join(path, name)
        shutil.move(name, location)
        print('\nSuccess !\nResults written to : ' + location)
