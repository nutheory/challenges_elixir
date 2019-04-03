defmodule ProdFib do
  def product_fib(n) do
    calc_prod(n, 0, 1)
  end

  def calc_prod(product, start, next) when start * next > product, do: [start, next, false]
  def calc_prod(product, start, next) when start * next === product, do: [start, next, true]

  def calc_prod(product, start, next) do
    calc_prod(product, next, start + next)
  end
end
