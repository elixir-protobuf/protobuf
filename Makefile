gen_google_proto: build_protoc_plugin
	protoc -I lib/google/protobuf/ --elixir_out=lib/google/protobuf/ --plugin=./protoc-gen-elixir lib/google/protobuf/descriptor.proto
	protoc -I lib/google/protobuf/ --elixir_out=lib/google/protobuf/ --plugin=./protoc-gen-elixir lib/google/protobuf/plugin.proto

build_protoc_plugin:
	mix escript.build .

clean:
	rm protoc-gen-elixir
