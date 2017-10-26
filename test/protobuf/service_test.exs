defmodule Protobuf.ServiceTest do
  use ExUnit.Case, async: true

  defmodule MyModule do
    use Protobuf.Service

    rpc :ping, MyInput, MyOutput
    rpc :pong, MyInput1, MyOutput2
    rpc :streamer, stream(MyInput1), MyOutput2
    rpc :streamer, stream(MyInput1), stream(MyOutput2)
    rpc :pathed, MyInput, MyOutput, post: "/path"
    rpc :pathed_2, MyInput, MyOutput, get: "/path/2"
  end

  test "rpcs are correct" do
    assert MyModule.rpcs == [
      {:ping, MyInput, MyOutput, []},
      {:pong, MyInput1, MyOutput2, []},
      {:streamer, {:stream, MyInput1}, MyOutput2, []},
      {:streamer, {:stream, MyInput1}, {:stream, MyOutput2}, []},
      {:pathed, MyInput, MyOutput, [post: "/path"]},
      {:pathed_2, MyInput, MyOutput, [get: "/path/2"]}
    ]
  end

end