defmodule Brainluck do
  defstruct status: :running,
            program: nil,
            instruct: nil,
            instruct_pos: 0,
            inputs: nil,
            data_pointers: %{},
            data_pos: 0

  def brain_luck(program, inputs) do
    # ",>,<[>[->+>+<<]>>[-<<+>>]<<<-]>>."
    # ",+[-.,+]"
    # <<67, 111, 100, 101, 119, 97, 114, 115, 255>>
    # , accept one byte of input, storing its value in the byte at the data pointer.
    # + increment (increase by one, truncate overflow: 255 + 1 = 0) the byte at the data pointer.
    # . output the byte at the data pointer.
    # [ if the byte at the data pointer is zero, then instead of moving the instruction pointer
    #     forward to the next command, jump it forward to the command after the matching ] command.
    # IO.inspect(hd(String.graphemes(program)))
    instruction(%Brainluck{
      instruct: hd(String.graphemes(program)),
      program: String.graphemes(program),
      inputs: :binary.bin_to_list(inputs)
    })
  end

  def instruction(%Brainluck{status: :running, instruct: ","} = state) do
    instruction(%Brainluck{
      state
      | instruct: Enum.at(state.program, state.instruct_pos + 1),
        instruct_pos: state.instruct_pos + 1,
        data_pointers:
          Map.put_new(state.data_pointers, map_size(state.data_pointers), hd(state.inputs)),
        inputs: List.delete_at(state.inputs, 0)
    })
  end

  def instruction(%Brainluck{status: :running, instruct: "+"} = state) do
    instruction(%Brainluck{
      state
      | instruct: Enum.at(state.program, state.instruct_pos + 1),
        instruct_pos: state.instruct_pos + 1,
        data_pointers: %{state.data_pos => state.data_pointers[state.data_pos] + 1}
    })
  end

  def instruction(
        %Brainluck{status: :running, instruct: "[", data_pointers: %{state.data_pos => 0}} = state
      ) do
    IO.inspect(state, label: "ZERO")
  end

  def instruction(%Brainluck{status: :running, instruct: "[", data_pointers: _} = state) do
    IO.inspect(state, label: "_")
  end
end
