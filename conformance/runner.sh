#!/bin/sh

MIX_ENV="test" mix run -e "Conformance.Protobuf.Runner.main([])"
