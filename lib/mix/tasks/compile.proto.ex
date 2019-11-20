defmodule Mix.Tasks.Compile.Proto do
  @moduledoc """
  Compiles protobuf types into elixir files

  ## Configuration

    * `:protoc_opts` - compilation options for the compiler. See below for options.

    Options:
    * `:src` - directory to find source files. Default to `"proto"`
    * `:target` - directory to put generated files. Default to `"lib"`
    * `:includes` - directories to look for imported definitions, in
      addition to `:src`. Default to `[]`
    * `:rpc` - uses grpc plugin
  """
  defmodule Options do
    @moduledoc """
    Defines a structure for compiler options
    """

    defstruct src: "./proto",
              target: "./lib",
              includes: [],
              rpc: false
  end

  @shortdoc "Compiles .proto file into elixir files"

  @task_name "compile.proto"

  use Mix.Task.Compiler

  @doc false
  def run(_args) do
    opts = get_options()

    srcs =
      opts.src
      |> Path.join("*.proto")
      |> Path.wildcard()

    errors = []

    errors =
      srcs
      |> Enum.reduce(errors, &check_src(&2, &1, "proto"))
      |> check_exec("protoc")
      |> check_exec("protoc-gen-elixir")
      |> do_compile(srcs, opts)

    case errors do
      [] ->
        :ok

      _ ->
        Enum.each(errors, &error/1)
        {:error, errors}
    end
  end

  @doc false
  def clean do
    opts = get_options()

    opts.target
    |> Path.join("*.pb.ex")
    |> Path.wildcard()
    |> case do
      [] ->
        :ok

      paths ->
        info("cleanup " <> Enum.join(paths, " "))
        Enum.each(paths, &File.rm/1)
    end
  end

  ###
  ### Priv
  ###
  defp get_options do
    project = Mix.Project.config()
    struct!(Options, project[:protoc_opts] || [])
  end

  defp do_compile([] = errors, srcs, opts) do
    :ok = File.mkdir_p(opts.target)

    targets = Enum.reduce(srcs, [], &(targets(&1, opts) ++ &2))

    if Mix.Utils.stale?(srcs, targets) do
      do_protoc(errors, srcs, opts)
    else
      errors
    end
  end

  defp do_compile(errors, _srcs, _opts), do: errors

  defp do_protoc(errors, srcs, opts) do
    _ =
      srcs
      |> Enum.join(" ")
      |> info()

    args =
      []
      |> Kernel.++(Enum.map([opts.src | opts.includes], &"-I #{&1}"))
      |> (&(if opts.rpc do
              &1 ++ ["--elixir_out=plugins=grpc:#{opts.target}"]
            else
              &1 ++ ["--elixir_out=#{opts.target}"]
            end)).()
      |> Kernel.++([Path.join(opts.src, "*.proto")])

    cmd = "protoc " <> Enum.join(args, " ")

    if Mix.shell().cmd(cmd) == 0 do
      errors
    else
      errors ++ ["Compilation failed"]
    end
  end

  defp targets(src, opts) do
    [Path.join([opts.target, Path.basename(src, ".proto") <> ".pb.ex"])]
  end

  defp info(msg) do
    Mix.shell().info([:bright, @task_name, :normal, " ", msg])
  end

  defp error(msg) do
    Mix.shell().info([:bright, @task_name, :normal, " ", :red, msg])
  end

  defp check_exec(errors, exec) do
    errors =
      if System.find_executable(exec) do
        errors
      else
        ["Missing executable: #{exec}" | errors]
      end

    errors
  end

  defp check_src(errors, src, ext) do
    if File.exists?(src) do
      check_ext(errors, src, ext)
    else
      ["Missing file: #{src}" | errors]
    end
  end

  defp check_ext(errors, src, ext) do
    if String.ends_with?(src, ".#{ext}") do
      errors
    else
      ["Source file #{src} doesn't match '*.#{ext}'" | errors]
    end
  end
end
