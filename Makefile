ndef = $(if $(value $(1)),,$(error $(1) not set))

protoc-gen-elixir:
	mix escript.build .

clean:
	rm -f protoc-gen-elixir

# PROTO_LIB should be your local path to https://github.com/google/protobuf/tree/master/src/google/protobuf
gen_google_proto: protoc-gen-elixir
	$(call ndef,PROTO_LIB)
	protoc -I $(PROTO_LIB) --elixir_out=lib/google --plugin=./protoc-gen-elixir $(PROTO_LIB)/descriptor.proto
	protoc -I $(PROTO_LIB) --elixir_out=lib/google --plugin=./protoc-gen-elixir $(PROTO_LIB)/compiler/plugin.proto
	protoc -I $(PROTO_LIB) -I src --elixir_out=lib/google --plugin=./protoc-gen-elixir src/elixir.proto

gen_test_protos: protoc-gen-elixir
	protoc -I src -I test/protobuf/protoc/proto --elixir_out=test/protobuf/protoc/proto_gen --plugin=./protoc-gen-elixir test/protobuf/protoc/proto/*.proto

.PHONY: clean gen_google_proto gen_test_protos
