defmodule Minerva.Assertions do
  @moduledoc false

  alias Minerva.Print

  def run(tests, module) do
    Enum.all?(tests, fn {test_func, description} ->
      apply(module, test_func, []) != :fail
    end)
  end

  def assert(operator, left, right, meta) do
    {operator, left, right}
    |> do_assert
    |> handle_result({operator, left, right}, meta)
  end

  defp do_assert({operator, left, right}) do
    case apply(Kernel, operator, [left, right]) do
      true -> :ok
      _ -> :fail
    end
  end

  defp handle_result(:ok, _meta, _meta) do
    :ok
  end

  defp handle_result(:fail, {operator, left, right}, meta) do
    IO.puts """
    Module: #{meta.module}
    Koan:   #{meta.description}

    #{Print.red(meta.code)}

    #{Print.blue("Meditate a little bit and try again =)")}
    """

    :fail
  end
end
