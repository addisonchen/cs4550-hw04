defmodule Practice.Factor do

    # take in a string
    # return true if it is an int
    defp isAnInt(str) do
        case Integer.parse(str) do
            {_num, ""} -> true
            _ -> false
        end
    end

    # parse an int
    defp parse_int(str) do
        {num, _} = Integer.parse(str)
        num
    end

    def doFactoring(x) do
        doFactoring(x, 2, [])
    end

    def doFactoring(x, factor, acc) do
        cond do
            factor * factor > x -> 
                cond do
                    x > 1 -> acc ++ [x]
                    true -> acc
                end
            rem(x, factor) == 0 -> doFactoring(Integer.floor_div(x, factor), factor, acc ++ [factor])
            true -> doFactoring(x, factor + 1, acc)
        end
    end

    def factor(x) when is_integer(x) do
        x
        |> doFactoring
        #|> Enum.reverse
    end

    def factor(x) when is_binary(x) do
        if isAnInt(x) do
            x
            |> parse_int
            |> doFactoring
            |> Enum.join(", ")
            #|> Enum.reverse
        else
            "Input not an integer"
        end
    end

end