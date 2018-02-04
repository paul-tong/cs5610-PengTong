defmodule Calc do
  @moduledoc """
  Implement + - * / four operations
  Parentheses are included
  Inputs and answers are all integers
  Use integer division for /
  """

  @doc """
  read expression from keyboard, eval it, and print the result

  ## Parameters
    - Input string expression from keyboard

  ## Return
    - the result of given expression
  """

  def main() do
    case IO.gets("> ") do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      expression ->
        IO.puts(eval(expression))
        main()
    end
  end


  @doc """
  parse and evaulate an arithmetic expression

  ## Parameters
    - ex : String that represents an arithmetic expression

  ## Return
    - Integer that represents the result of given expression

  ## Examples

      iex> Calc.eval("2 + 3")
      5
      iex> Calc.eval("20 / 4")
      5
      iex> Calc.eval("24 / 6 + (5 - 4)")
      5
      iex> Calc.eval("(5 - 4) * 3")
      3
      iex> Calc.eval("3 * (1 + 2) * (5 - 2)")
      27
      iex> Calc.eval("3 * ((1 + 2) - 4) * 2")
      -6
      iex> Calc.eval("1 + 3 * 3 + 1")
      11
  """
  def eval(ex) do
    ex |> String.replace("(", "( ")
       |> String.replace(")", " )")
       |> String.split()
       |> change_to_integer()
       |> eval_list()
  end



 @doc """
  change numbers in the list from string type to integer type

  ## Parameters
    - l : List that represents an arithmetic expression

  ## Examples
      iex> Calc.change_to_integer(["2", "+", "3"])
      [2, "+", 3]
      iex> Calc.change_to_integer(["(", "5", "-", "4", ")", "*", "3"])
      ["(", 5, "-", 4, ")", "*", 3]
  """

  def change_to_integer(l) do
    Enum.reduce(l, [], fn(x, acc) ->
      if x == "+" or x == "-" or x == "*" or x == "/" or x == "(" or x == ")" do
        acc ++ [x]
      else
        acc ++ [String.to_integer(x)]
      end
    end)
  end



  @doc """
  parse and evaulate an arithmetic expression

  ## Parameters
    - l : List that represents an arithmetic expression

  ## Return
    - Integer that represents the result of given expression

  ## Examples

      iex> Calc.eval_list([2, "+", 3])
      5
      iex> Calc.eval_list([20, "/", 4])
      5
      iex> Calc.eval_list(["(", 5, "-", 4, ")", "*", 3])
      3
  """
  def eval_list(l) do
    last = Enum.count(l) - 1  # last index of the list 
    cond do
      Enum.count(l) == 0 ->
        0
      Enum.count(l) == 1 ->
        Enum.at(l, 0)
      Enum.at(l, 0) == "(" ->
        p = get_parenth_position(l, 0, 0)  # position of corresponding ")" for this "("
        [Enum.slice(l, 1..p - 1) |> eval_list] 
          ++ Enum.slice(l, p + 1..last)
          |> eval_list()
      Enum.at(l, 2) == "(" ->
        p = get_parenth_position(l, 0, 0)
        Enum.slice(l, 0..1) 
          ++ [Enum.slice(l, 3..p - 1) |> eval_list] 
          ++ Enum.slice(l, p + 1..last)
          |> eval_list()
      Enum.at(l, 1) == "/" ->
        [div(Enum.at(l, 0), Enum.at(l, 2))] 
          ++ Enum.slice(l, 3..last)
          |> eval_list()
      Enum.at(l, 1) == "*" ->
        [Enum.at(l, 0) * Enum.at(l, 2)] 
          ++ Enum.slice(l, 3..last)
          |> eval_list()
      Enum.at(l, 1) == "+" ->
          Enum.at(l, 0) + (Enum.slice(l, 2..last)|> eval_list())
      Enum.at(l, 1) == "-" and (Enum.at(l, 3) == "*" or (Enum.at(l, 3) == "/"))->
          Enum.at(l, 0) - (Enum.slice(l, 2..last)|> eval_list())
      true ->
        [Enum.at(l, 0) - Enum.at(l, 2)] 
          ++ Enum.slice(l, 3..last)
          |> eval_list()
    end
  end
    


 @doc """
  get the position of corresponding right parenthese for the first left parenthese

  ## Parameters
    - l   : List that represents an arithmetic expression
    - num : number of remaining left parentheses that need to be paired
    - pos : current position in the list

  ## Examples
      iex> Calc.get_parenth_position(["(", "5", "-", "4", ")", "*", "3"], 0, 0)
      4
      iex> Calc.get_parenth_position(["3", "*", "(", "(", "1", "-", "2", ")", "+", "4", ")", "*", "2"], 0, 0)
      10
  """

  def get_parenth_position(l, num, pos) do
    cond do
      hd(l) == ")" and num == 1 -> pos
      hd(l) == ")" and num > 1 -> get_parenth_position(tl(l), num - 1, pos + 1)
      hd(l) == "(" -> get_parenth_position(tl(l), num + 1, pos + 1)
      true -> get_parenth_position(tl(l), num, pos + 1)
    end
  end

end
