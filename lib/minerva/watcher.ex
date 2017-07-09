defmodule Minerva.Watcher do
  @moduledoc false

  use ExFSWatch, dirs: [Application.get_env(:minerva, :files)]

  def callback(:stop) do
    IO.puts "STOP"
  end

  def callback(filepath, events) do
    cond do
      :modified in events && Path.extname(filepath) == ".ex" ->
        Minerva.test(filepath)
      true ->
        nil
    end
  end
end
