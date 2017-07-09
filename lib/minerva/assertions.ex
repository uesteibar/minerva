defmodule Minerva.Assertions do
  @moduledoc false

  def run(tests, module) do
    Enum.all?(tests, fn {test_func, _} ->

      result = module
        |> apply(test_func, [])

      result != :fail
    end)
  end

  def assert({operator, left, right}) do
    {operator, left, right}
    |> do_assert
  end

  def assert(boolean) do
    case boolean do
      true -> :ok
      _ -> raise("fail")
    end
  end

  defp do_assert({operator, left, right}) do
    case apply(Kernel, operator, [left, right]) do
      true -> :ok
      _ -> raise("fail")
    end
  end
end
