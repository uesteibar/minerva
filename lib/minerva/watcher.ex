defmodule Minerva.Watcher do
  @moduledoc false

  use ExFSWatch, dirs: [Application.get_env(:minerva, :files)]

  def callback(:stop) do
    IO.puts "STOP"
  end

  def callback(file_path, events) do
    Minerva.test(file_path)
  end
end
