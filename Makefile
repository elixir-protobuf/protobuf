ndef = $(if $(value $(1)),,$(error $(1) not set))

protoc-gen-elixir:
	mix escript.build .

clean:
	rm protoc-gen-elixir

# PROTO_LIB should be your local path to https://github.com/google/protobuf/tree/master/src/google/protobuf
gen_google_proto: protoc-gen-elixir
	$(call ndef,PROTO_LIB)
	protoc -I $(PROTO_LIB) --elixir_out=lib/google --plugin=./protoc-gen-elixir $(PROTO_LIB)/descriptor.proto
	protoc -I $(PROTO_LIB) --elixir_out=lib/google --plugin=./protoc-gen-elixir $(PROTO_LIB)/compiler/plugin.proto

.PHONY: clean gen_google_proto
