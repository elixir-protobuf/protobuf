# Changelog

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

