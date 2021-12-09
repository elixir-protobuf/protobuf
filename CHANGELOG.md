# Changelog

## v0.9.0

### Enhancements

Most of the enhancements in this release concern JSON support.

  * JSON support for Google types. The library now supports JSON mapping of
    `Google.Protobuf.*` types such as timestamps, durations, type wrappers, and
    so on. In order to use this correctly, you need to manually generate the
    Protobuf Elixir files from the `.proto` files provided by Google since they
    are not shipped with this library.
  * Accept integer numbers for float fields when decoding JSON.
  * Add `Protobuf.encode_to_iodata/1`.
  * Add the `one_file_per_module` CLI option when using the `protoc-gen-elixir`
    plugin.
  * Use type-aware defaults in struct definitions for Protobuf messages. This
    means that now doing `%MyMessage{}` should be equivalent to
    `MyMessage.new()`.
  * Don't generate the `transformer_module/0` callback in generated Protobuf
    modules if the `transformer_module` CLI option is not used.

### Bug fixes

  * Fix enum aliasing in JSON mapping.
  * Fix encoding of default values when using transformer modules.
  * Raise a `Protobuf.DecodeError` when decoding if fields with number `0` are
    encountered.
  * Fix bugs when decoding big varints, integers, and so on (by casting).
  * Cast enum integers to int32 when they overflow when decoding.
  * Skip encoding for fields if they match their user-defined default in proto2.
  * Fix decoding and encoding of packed repeated fields.
  * Don't pack fields that use the `[packed = false]` option explicitly in
    proto3.

## v0.8.0

### Enhancements

  * [JSON](https://developers.google.com/protocol-buffers/docs/proto3#json)
    encoding and decoding support.
  * [Extensions](https://developers.google.com/protocol-buffers/docs/proto#extensions)
    support.
  * [Enum alias](https://developers.google.com/protocol-buffers/docs/proto3#enum)
    (`allow_alias`) support.
  * Faster and more memory-efficient encoding and decoding algorithms.
  * More accurate typespecs for repeated fields and enums.
  * Add `package_prefix` command-line option to control namespacing on generated
    code.
  * Add `transform_module` command-line option with hooks for custom pre-encode
    and post-decode logic.

### Bug fixes

  * Fix decoding of proto2 payloads containing legacy `group` fields. Instead of
    crashing the decoder, those fields are now skipped.
  * Fix compilation warnings on recent versions of Elixir.
  * Fix `new!` to raise `ArgumentError` when given struct and module don't match.

### Breaking changes

  * Dropped support to OTP 21.1 and lower.

## v0.7.1 (2020-01-07)

### Enhancements

  * Add typespec generation for enum fields.
  * Add `new!/1` function to generated modules with strict field validation.
  * Raise `Protobuf.DecodeError` when unable to decode binary input.
  * Add `--version` command-line flag.

## v0.7.0 (2019-12-19)

## v0.6.3 (2019-08-19)
