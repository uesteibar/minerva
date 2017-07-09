defmodule Minerva.Koans do
  @moduledoc false

  alias Minerva.{Assertions, Print}

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        Assertions.run(Enum.reverse(@tests), __MODULE__)
      end
    end
  end

  defmacro koan(description, do: test_block) do
    test_func = String.to_atom(description)
    code = cleanup_code(test_block)

    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)() do
        var!(___) = nil
        try do
          unquote(test_block)
        rescue
          _ ->
            Print.failure(%{
              code: unquote(code),
              description: unquote(description),
              module: unquote(__MODULE__),
            })
        end
      end
    end
  end

  defmacro assert({operator, _, [left, right]}) do
    quote bind_quoted: [operator: operator, left: left, right: right] do
      Assertions.assert({operator, left, right})
    end
  end

  defmacro assert(boolean) do
    quote bind_quoted: [boolean: boolean] do
      Assertions.assert(boolean)
    end
  end

  defp cleanup_code(ast) do
    ast
    |> Macro.to_string
    |> String.split("\n")
    |> remove_parethesis()
    |> Enum.join("\r\n\r\n")
  end

  defp remove_parethesis(ast) do
    case List.first(ast) do
      "(" ->
        ast |> List.delete_at(0) |> List.delete_at(length(ast) - 2)
      _ ->
        ast
    end
  end
end
