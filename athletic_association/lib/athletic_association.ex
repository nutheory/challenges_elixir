# Range : difference between the lowest and highest values. In {4, 6, 9, 3, 7}
# the lowest value is 3, and the highest is 9, so the range is 9 − 3 = 6.

# Mean or Average : To calculate mean, add together all of the numbers in a set
# and then divide the sum by the total count of numbers.

# Median : In statistics, the median is the number separating the higher half
# of a data sample from the lower half. The median of a finite list of numbers
# can be found by arranging all the observations from lowest value to highest
# value and picking the middle one (e.g., the median of {3, 3, 5, 9, 11} is 5)
# when there is an odd number of observations. If there is an even number of
# observations, then there is no single middle value; the median is then defined
# to be the mean of the two middle values (the median of {3, 5, 6, 9} is (5 + 6) / 2 = 5.5).

# Your task is to return a string giving these 3 values. For the example given
# above, the string result will be

# "Range: 00|47|18 Average: 01|35|15 Median: 01|32|34"

defmodule AthleticAssociation do
  defp format_zero(num) do
    str = Integer.to_string(num)

    cond do
      byte_size(str) < 2 -> "0" <> str
      true -> str
    end
  end

  defp range(times) do
    max = Enum.reverse(times)
    dt1 = Time.new(Enum.at(hd(times), 0), Enum.at(hd(times), 1), Enum.at(hd(times), 2))
    dt2 = Time.new(Enum.at(hd(max), 0), Enum.at(hd(max), 1), Enum.at(hd(max), 2))

    hour = Integer.floor_div(Time.diff(elem(dt2, 1), elem(dt1, 1)), 3600) |> format_zero
    h_left = rem(Time.diff(elem(dt2, 1), elem(dt1, 1)), 3600)
    minute = Integer.floor_div(h_left, 60) |> format_zero
    second = rem(h_left, 60) |> format_zero

    "Range: #{hour}|#{minute}|#{second}"
  end

  defp average(times, frmt) do
    IO.inspect(times, label: frmt)

    total =
      Enum.reduce(times, 0, fn time, m_acc ->
        t =
          Enum.with_index(time)
          |> Enum.reduce(0, fn prt, s_acc ->
            cond do
              elem(prt, 1) === 0 -> s_acc + elem(prt, 0) * 3600
              elem(prt, 1) === 1 -> s_acc + elem(prt, 0) * 60
              elem(prt, 1) === 2 -> s_acc + elem(prt, 0)
            end
          end)

        m_acc + t
      end)
      |> Integer.floor_div(length(times))

    hours = trunc(div(total, 3600))
    t_left = total - hours * 3600
    minutes = trunc(div(t_left, 60))
    seconds = t_left - minutes * 60

    if frmt === "int" do
      [hours, minutes, seconds]
    else
      "Average: #{format_zero(hours)}|#{format_zero(minutes)}|#{format_zero(seconds)}"
    end
  end

  defp median(times) do
    med =
      if rem(length(times), 2) !== 0 do
        Enum.at(times, Integer.floor_div(length(times), 2))
      else
        c = Integer.floor_div(length(times), 2) - 1
        average([Enum.at(times, c), Enum.at(times, c + 1)], "int")
      end

    IO.inspect(med, label: "MED")

    "Median: #{format_zero(Enum.at(med, 0))}|#{format_zero(Enum.at(med, 1))}|#{
      format_zero(Enum.at(med, 2))
    }"
  end

  def stat(string) when string !== "" do
    timesArr =
      String.split(string, [", "])
      |> Enum.map(fn time ->
        String.split(time, ["|"])
        |> Enum.map(fn int ->
          String.to_integer(int)
        end)
      end)
      |> Enum.sort()

    "#{range(timesArr)} #{average(timesArr, nil)} #{median(timesArr)}"
  end

  def stat(_) do
    ""
  end
end
