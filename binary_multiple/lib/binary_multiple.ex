defmodule BinaryMultiple do
  def multipleOf3Regex do
    ~r/^(0|1(01*0)*1)*$/
  end
end
