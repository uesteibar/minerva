defmodule Minerva.Print do
  @moduledoc false

  def instructions do
    """
    Welcome to the koan!
    ######################

    The exercises are found somewhere under #{Application.get_env(:minerva, :files)}.
    Just fill the gaps (anywhere you see ___, that's a gap),
    save the file and come back here!
    """
    |> green()
    |> IO.puts
  end

  def finish do
    """
    Congratulations!

    You completed all koans successfully.
    Time to relax!
    """
    |> green()
    |> IO.puts
  end

  def red(str), do: colourize(IO.ANSI.red, str)
  def blue(str), do: colourize(IO.ANSI.blue, str)
  def green(str), do: colourize(IO.ANSI.green, str)

  def clear_screen do
    IO.puts(IO.ANSI.clear())
    IO.puts(IO.ANSI.home())
  end

  defp colourize(color, message) do
    Enum.join([color, message, IO.ANSI.reset], "")
  end
end
