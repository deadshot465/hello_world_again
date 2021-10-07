defmodule Rpn do
  def rpn(input) do
    if !is_binary(input) do
      throw("The input has to be a string.")
    else
      [result] = Enum.reduce(String.split(input), [], &rpn/2)
      result
    end
  end

  @spec rpn(binary, any) :: nonempty_maybe_improper_list
  def rpn("+", [n1, n2 | xs]), do: [n2 + n1 | xs]
  def rpn("-", [n1, n2 | xs]), do: [n2 - n1 | xs]
  def rpn("*", [n1, n2 | xs]), do: [n2 * n1 | xs]
  def rpn("/", [n1, n2 | xs]), do: [n2 / n1 | xs]
  def rpn("^", [n1, n2 | xs]), do: [Float.pow(n2, n1) | xs]
  def rpn("ln", [n | xs]), do: [:math.log(n) | xs]
  def rpn("log10", [n | xs]), do: [:math.log10(n) | xs]
  def rpn("sum", xs), do: [Enum.sum(xs)]
  def rpn("prod", xs), do: [Enum.product(xs)]
  def rpn(x, xs), do: [read(x) | xs]

  @spec read(binary) :: number
  def read(s) do
    case Float.parse(s) do
      {float, _} -> float
      :error ->
        {integer, _} = Integer.parse(s)
        integer
    end
  end
end
