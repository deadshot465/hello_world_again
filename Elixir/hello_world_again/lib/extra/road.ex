defmodule Road do
  def run() do
    file = "road.txt"
    {:ok, binary} = File.read(file)
    parse_map(binary)
    |> group_values([])
    |> optimal_path()
  end

  @spec parse_map(binary) :: [integer()]
  def parse_map(string) do
    String.split(string, ["\r", "\n", "\t", " "], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def group_values([], acc), do: Enum.reverse(acc)
  def group_values([a, b, x | xs], acc) do
    group_values(xs, [{a, b, x} | acc])
  end

  def shortest_steps(elem, acc) do
    {a, b, x} = elem
    { {dist_a, path_a}, {dist_b, path_b} } = acc
    opt_a1 = { dist_a + a, [{:a, a} | path_a] }
    opt_a2 = { dist_b + b + x, [{:x, x}, {:b, b} | path_b] }
    opt_b1 = { dist_b + b, [{:b, b} | path_b] }
    opt_b2 = { dist_a + a + x, [{:x, x}, {:a, a} | path_a] }
    { min(opt_a1, opt_a2), min(opt_b1, opt_b2) }
  end

  def optimal_path(values) do
    { a, b } = Enum.reduce(values, { {0, []}, {0, []} }, &shortest_steps/2)
    { _, path } = if hd(elem(a, 1)) != {:x, 0} do
      a
    else
      if hd(elem(b, 1)) != {:x, 0} do
        b
      else
        { 0, [] }
      end
    end
    Enum.reverse(path)
  end
end
