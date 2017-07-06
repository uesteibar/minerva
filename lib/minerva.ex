defmodule Minerva do
  @moduledoc """
  Minerva is a GenServer that will start up everything you need for the framework to work.
  """

  use GenServer

  alias Minerva.{Print, Watcher}

  @doc """
  Starts up the Minerva GenServer.
  As first argument, it expects a list of modules using Minerva.Koans (see docs).
  """
  def start_link(koan_modules) do
    GenServer.start_link(__MODULE__, koan_modules, name: :minerva_koan_runner)
  end

  @doc false
  def init(mods) do
    Watcher.start()

    run_all(mods, true)

    {:ok, %{mods: mods}}
  end

  @doc false
  def handle_info(_, state), do: {:noreply, state}

  @doc false
  def handle_cast({:test, filepath}, %{mods: mods} = state) do
    Code.load_file(filepath)
    run_all(mods)

    {:noreply, state}
  end

  @doc false
  def test(filepath) when is_binary(filepath) do
    GenServer.cast(:minerva_koan_runner, {:test, filepath})
  end

  defp run_all(mods, first_run? \\ false) do
    all_green? = Enum.all?(mods, fn (mod) ->
      Print.clear_screen()
      if first_run? do
        Print.instructions()
      end
      mod.run()
    end)

    if all_green? do
      Print.finish()
    end
  end
end
