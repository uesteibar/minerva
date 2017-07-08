defmodule Minerva.Assertions do
  @moduledoc false

  alias Minerva.Print

  def run(tests, module) do
    Enum.all?(tests, fn {test_func, description, code} ->
      module_name = module |> Module.split |> List.last
      result = module
        |> apply(test_func, [])
        |> handle_result(%{code: code, description: description, module: module_name})

      result != :fail
    end)
  end

  def assert(operator, left, right) do
    {operator, left, right}
    |> do_assert
  end

  def assert(boolean) do
    case boolean do
      true -> :ok
      _ -> raise(:fail)
    end
  end

  defp do_assert({operator, left, right}) do
    case apply(Kernel, operator, [left, right]) do
      true -> :ok
      _ -> raise(:fail)
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
