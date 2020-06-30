#!/bin/sh
set -ev

cd -P -- "$(dirname -- "$0")"

curl -O https://storage.googleapis.com/protobuf_opensource_benchmark_data/datasets.tar.gz
tar -zvxf datasets.tar.gz
