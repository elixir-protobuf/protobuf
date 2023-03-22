defmodule Protobuf.Compat do

  def is_compat? do
    Application.get_env(:protobuf, :compat, false)
  end

end
