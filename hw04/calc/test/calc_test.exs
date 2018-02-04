defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "eval" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("20 / 4") == 5
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("3 * (1 + 2) * (5 - 2)") == 27
    assert Calc.eval("3 * ((1 + 2) - 4) * 2") == -6
    assert Calc.eval("1 + 3 * 3 + 1") == 11
    assert Calc.eval("1 - 3 * (3 + 1)") == -11
  end

  test "change_to_integer" do
    assert Calc.change_to_integer(["2", "+", "3"]) == [2, "+", 3]
    assert Calc.change_to_integer(["(", "5", "-", "4", ")", "*", "3"]) == ["(", 5, "-", 4, ")", "*", 3]
  end

  test "eval_list" do
    assert Calc.eval_list([2, "+", 3]) == 5
    assert Calc.eval_list([20, "/", 4]) == 5
    assert Calc.eval_list(["(", 5, "-", 4, ")", "*", 3]) == 3
  end

  test "get_parenth_position" do
    assert Calc.get_parenth_position(["(", "5", "-", "4", ")", "*", "3"], 0, 0) == 4
    assert Calc.get_parenth_position(["3", "*", "(", "(", "1", "-", "2", ")", "+", "4", ")", "*", "2"], 0, 0) == 10
  end

end
