defmodule Minerva.Assertions do
  @moduledoc false

  alias Minerva.Print

  def run(tests, module) do
    Enum.all?(tests, fn {test_func, _} ->
      apply(module, test_func, []) != :fail
    end)
  end

  def assert(operator, left, right, meta) do
    {operator, left, right}
    |> do_assert
    |> handle_result(meta)
  end

  def assert(boolean, meta) do
    case boolean do
      true -> handle_result(:ok, meta)
      _ -> handle_result(:fail, meta)
    end
  end

  defp do_assert({operator, left, right}) do
    case apply(Kernel, operator, [left, right]) do
      true -> :ok
      _ -> :fail
    end
  end

  defp handle_result(:ok, _meta) do
    :ok
  end

  defp handle_result(:fail, meta) do
    IO.puts """
    Module: #{meta.module}
    Koan:   #{meta.description}

    #{Print.red(meta.code)}

    #{Print.blue("Meditate a little bit and try again =)")}
    """

    :fail
  end
end
