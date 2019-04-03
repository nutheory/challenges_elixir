defmodule Brainfuck do
  # @dp = 0

  def brain_luck(program, inputs) do
    # ",+[-.,+]"
    # <<67, 111, 100, 101, 119, 97, 114, 115, 255>>
    # , accept one byte of input, storing its value in the byte at the data pointer.
    # + increment (increase by one, truncate overflow: 255 + 1 = 0) the byte at the data pointer.
    # . output the byte at the data pointer.
    # [ if the byte at the data pointer is zero, then instead of moving the instruction pointer
    #     forward to the next command, jump it forward to the command after the matching ] command.
    # IO.inspect(hd(String.graphemes(program)))
    input_list = :binary.bin_to_list(inputs)
    stop = List.last(input_list)

    instruction(
      hd(String.graphemes(program)),
      String.graphemes(program),
      0,
      input_list,
      0,
      0,
      stop
    )

    # IO.inspect(inputs)
  end

  def instruction(_, _, pointer, inputs, _, _, stop)
      when stop === pointer do
    IO.inspect(inputs)

    inputs
    |> Enum.reverse()
    |> List.delete_at(0)
    |> Enum.reverse()
    |> List.to_string()
    |> IO.inspect()
  end

  def instruction(",", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "COMMA: pointer")

    instruction(
      Enum.at(program, program_idx + 1),
      program,
      Enum.at(inputs, inputs_idx),
      inputs,
      program_idx + 1,
      inputs_idx + 1,
      stop
    )
  end

  def instruction("+", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "PLUS: pointer")

    new_pointer =
      if pointer > 255 do
        0
      else
        pointer + 1
      end

    instruction(
      Enum.at(program, program_idx + 1),
      program,
      new_pointer,
      inputs,
      program_idx + 1,
      inputs_idx,
      stop
    )
  end

  def instruction("-", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "MINUS: pointer")

    new_pointer =
      if pointer < 0 do
        255
      else
        pointer - 1
      end

    instruction(
      Enum.at(program, program_idx + 1),
      program,
      new_pointer,
      inputs,
      program_idx + 1,
      inputs_idx,
      stop
    )
  end

  def instruction(".", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "DOT: pointer")
    IO.puts(pointer)

    instruction(
      Enum.at(program, program_idx + 1),
      program,
      pointer,
      inputs,
      program_idx + 1,
      inputs_idx,
      stop
    )
  end

  def instruction("[", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "LBRA: pointer")

    new_program_idx =
      if pointer === 0 do
        Enum.find_index(program, fn x -> x === "]" end) + 1
      else
        program_idx + 1
      end

    instruction(
      Enum.at(program, new_program_idx),
      program,
      pointer,
      inputs,
      new_program_idx,
      inputs_idx,
      stop
    )
  end

  def instruction("]", program, pointer, inputs, program_idx, inputs_idx, stop) do
    IO.inspect(pointer, label: "RBRA: pointer")

    new_program_idx =
      if pointer === 0 do
        program_idx + 1
      else
        Enum.find_index(program, fn x -> x === "[" end) + 1
      end

    instruction(
      Enum.at(program, new_program_idx),
      program,
      pointer,
      inputs,
      new_program_idx,
      inputs_idx,
      stop
    )
  end
end
