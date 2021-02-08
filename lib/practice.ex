defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Practice.Factor.factor(x)
  end

  # TODO: Add a palindrome? function.
  def palindrome?(x) do
    # remove invalid characters
    s = String.replace(x, ~r/[^0-9a-zA-Z ]/, "")
    # remove whitespace
    s = s |> String.split |> Enum.join("")
    # make it into a list
    l = s |> String.split("", trim: true)
    # make a reversed list
    r = Enum.reverse(l)
    # return if the reverse is the same as forwards
    l == r
  end
end
