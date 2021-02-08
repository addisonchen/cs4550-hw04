defmodule Practice.Calc do
  defp parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  # take in a string
  # return true if it is a number
  defp isANumber(str) do
    case Float.parse(str) do
      {_num, ""} -> true
      _ -> false
    end
  end

  # take in a string
  # return 
  defp isAOp(str) do
    case str do
      "+" -> true
      "-" -> true
      "/" -> true
      "*" -> true
      _ -> false
    end
  end

  # check if an expression list is valid
  # - no numbers followed by numbers
  # - no ops followed by ops
  # - start with a number
  # - end with a number
  defp isValid(exprl) do
    unless length(exprl) >= 3 do
      false
    end

    allValidSymbols = Enum.reduce(exprl, true, fn(x, acc) ->
      acc && (isAOp(x) || isANumber(x))
    end)

    order = Enum.reduce(exprl, %{soFar: true, prev: "-"}, fn(x, acc) ->
      cond do
        isAOp(acc.prev) && isANumber(x) -> %{soFar: acc.soFar && true, prev: x}
        isANumber(acc.prev) && isAOp(x) -> %{soFar: acc.soFar && true, prev: x}
        true -> %{soFar: acc.soFar && false, prev: x}
      end
    end)
    order.soFar && allValidSymbols && isANumber(order.prev)
  end

  # take an expression list 
  # remove non number or operation characters
  defp filterInvalid(exprl) do
    Enum.filter(exprl, fn(x) ->
      isANumber(x) || isAOp(x)
    end)
  end

  # Take a list of nums and ops
  # Return a tagged list of expressions
  defp tag(exprl) do
    Enum.map(exprl, fn(x) ->
      cond do
        isANumber(x) -> {:num, parse_float(x)}
        isAOp(x) -> {:op, x}
        true -> raise "Expected oper or number, got: #{x}"
      end
    end)
  end

  # take a tagged expression list and set it into postfix
  def postfix(texprl) do
    postfix(texprl, [], [])
  end

  # handles recursion for postfix with non empty stack
  def postfix([head | tail], stack, result) do
    case head do
      # number, add to end of result
      {:num, x} -> postfix(tail, stack, result ++ [{:num, x}])
      # operation, determine if has precedence
      {:op, op} -> 
        cond do
          Enum.empty?(stack) -> postfix(tail, [op], result)
          # push to stack if greater precedence than head of stack
          greaterPrecedence(op, hd(stack)) -> postfix(tail, [op | stack], result)
          # pop from stack, do not remove head of texprl, append head of stack to end of result
          true -> postfix([head | tail], tl(stack), result ++ [{:op, hd(stack)}])
        end
      # unknown
      _ -> raise "unknown thing in postfix: #{head}"
    end
  end

  # handles end of postfixing recursion, empty the stack and append to result
  def postfix([], [head | tail], result) do
    postfix([], tail, result ++ [{:op, head}])
  end

  # all stacks empty, return result
  def postfix([], [], result) do
    result
  end

  # determine if first arg has greater precedence than second arg
  # * = /
  # + = -
  # */ > +-
  defp greaterPrecedence(op1, op2) do
    case op1 do
      "+" -> false
      "-" -> false
      # must be * or div
      _ -> ((op2 == "+") || (op2 == "-"))
    end
  end

  # caclulate a tagged postfix expression list
  def postfixCalculate(texprl) do
    postfixCalculate(texprl, [])
  end

  # handle the recursion to do postfix calculations
  def postfixCalculate([head | tail], stack) do
    case head do
      {:num, x} -> postfixCalculate(tail, [x | stack])
      {:op, op} -> postfixCalculate(tail, calculate(op, stack))
      _ -> raise "something fishy in calculate #{head}"
    end
  end
  
  # final case, empty texprl
  def postfixCalculate([], stack) do
    hd(stack)
  end


  # handle one calculation, take two off the stack, push result
  # return stack
  def calculate(op, stack) do
    num1 = hd(stack)
    num2 = hd(tl(stack))
    case op do
      "+" -> [num2 + num1 | tl(tl(stack))]
      "-" -> [num2 - num1 | tl(tl(stack))]
      "/" -> [num2 / num1 | tl(tl(stack))]
      "*" -> [num2 * num1 | tl(tl(stack))]
      _ -> raise "unknown operator in calculate: #{op}"
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    exprl = expr 
      |> String.split(~r/\s+/) 
      |> filterInvalid

    if isValid(exprl) do
      exprl
      |> tag
      |> postfix
      |> postfixCalculate
    else
      "Invalid input"
    end
    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
