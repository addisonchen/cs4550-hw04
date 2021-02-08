defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  defp calcCheckEmpty(expr) do
    if (expr == "") do
      Practice.calc("0")
    else
      Practice.calc(expr)
    end
  end

  def calc(conn, %{"expr" => expr}) do
    y = calcCheckEmpty(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    y = Practice.factor(x)
    render conn, "factor.html", x: x, y: y
  end

  # TODO: Add an action for palindrome.
  # TODO: Add a template for palindrome over in lib/*_web/templates/page/??.html.eex
  def palindrome(conn, %{"x" => x}) do
    y = Practice.palindrome?(x)
    if y do
      render conn, "palindrome.html", x: x, y: "yes"
    else 
      render conn, "palindrome.html", x: x, y: "no"
    end
  end
end
