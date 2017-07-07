defmodule Minerva.Watcher do
  @moduledoc false

  use ExFSWatch, dirs: [Application.get_env(:minerva, :files)]

  def callback(:stop) do
    IO.puts "STOP"
  end

  def callback(file_path, events) do
    cond do
      :modified in events -> Minerva.test(file_path)
      true -> nil
    end
  end
end
