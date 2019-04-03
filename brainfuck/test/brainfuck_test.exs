defmodule BrainfuckTest do
  use ExUnit.Case

  test "echo until byte 255 is encoutered" do
    assert Brainfuck.brain_luck(",+[-.,+]", "Codewars" <> <<255>>) == "Codewars"
  end

  test "echo until byte 0 is encoutered" do
    assert Brainfuck.brain_luck(",[.[-],]", "Codewars" <> <<0>>) == "Codewars"
  end

  test "multiplies two number" do
    assert Brainfuck.brain_luck(",>,<[>[->+>+<<]>>[-<<+>>]<<<-]>>.", <<8, 9>>) == <<72>>
  end
end
