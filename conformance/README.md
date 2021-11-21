# Protobuf Conformance Tests

## Prerequisites

You'll need to compile the Protobuf conformance test runner binary. The
instructions can be found [in the Protobuf
repository][conformance-instructions].

## Running the Tests

Once you've successfully compiled the runner, you can run the tests with the
following command:

```sh
mix conformance_tests --runner=$PATH_TO_RUNNER
```

You should expect to see an output similar to this:

```sh
CONFORMANCE TEST BEGIN ====================================

CONFORMANCE SUITE PASSED: 1179 successes, 705 skipped, 123 expected failures, 0 unexpected failures.


CONFORMANCE TEST BEGIN ====================================

CONFORMANCE SUITE PASSED: 0 successes, 69 skipped, 0 expected failures, 0 unexpected failures.
```

### Debugging a Conformance Test

Add the `--verbose` flag to the above command to get detailed messages which can
help aid in fixing conformance issues.

```sh
mix conformance_tests --runner=$PATH_TO_RUNNER --verbose
```

## Regenerating the Conformance Protobuf Test Schemas

To regenerate the `.pb.ex` files for the Protobuf test schemas included (such as
[this one][test-message-protobuf-schema-source]), run the following commands
from the root of this repo:

```sh
# This is the path to the root of your clone of
# https://github.com/protocolbuffers/protobuf.
export PROTO_ROOT="/path/to/root/of/protobuf/clone"

protoc \
    --plugin="./protoc-gen-elixir" \
    --elixir_out=./conformance \
    -I "$PROTO_ROOT/src/google" \
    "$PROTO_ROOT/src/google/protobuf/test_messages_proto2.proto" \
    "$PROTO_ROOT/src/google/protobuf/test_messages_proto3.proto"

mix format
```

## Exemptions

[`conformance/exemptions.txt`][exemptions-file] contains a list of
tests that are currently failing conformance tests. When fixing issues
identified by the conformance test, remove the corresponding test lines from
this file to ensure test regressions do not occur.

[exemptions-file]: ./conformance/exemptions.txt
[conformance-instructions]: https://github.com/protocolbuffers/protobuf/blob/master/conformance/README.md
[test-message-protobuf-schema-source]: https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/test_messages_proto2.proto
