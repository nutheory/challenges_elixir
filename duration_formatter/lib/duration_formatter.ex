defmodule DurationFormatter
  defstruct total_count: nil,
            years: nil,
            days: nil,
            hours: nil,
            minutes: nil,
            seconds: nil

  def format_duration(seconds) do
    parse_seconds(%DurationFormatter{total_count: seconds})
  end

  def parse_seconds(%DurationFormatter{total_count: count} = state) when count === 0 do

    cond do
      state.years && state.days && state.hours && state.minutes && state.seconds ->
        "#{state.years}, #{state.days}, #{state.hours}, #{state.minutes} and #{state.seconds}"

      state.years && state.days && state.minutes && state.seconds ->
        "#{state.years}, #{state.days}, #{state.minutes} and #{state.seconds}"

      state.years && state.days && state.hours && state.minutes ->
        "#{state.years}, #{state.days}, #{state.hours} and #{state.minutes}"

      state.years && state.hours && state.minutes && state.seconds ->
        "#{state.years}, #{state.hours}, #{state.minutes} and #{state.seconds}"

      state.years && state.minutes && state.seconds ->
        "#{state.years}, #{state.minutes} and #{state.seconds}"

      state.years && state.seconds ->
        "#{state.years}, and #{state.seconds}"

      state.days && state.hours && state.minutes && state.seconds ->
        "#{state.days}, #{state.hours}, #{state.minutes} and #{state.seconds}"

      state.days && state.hours && state.minutes ->
        "#{state.days}, #{state.hours} and #{state.minutes}"

      state.days && state.minutes && state.seconds ->
        "#{state.days}, #{state.minutes} and #{state.seconds}"

      state.days && state.seconds ->
        "#{state.years} and #{state.seconds}"

      state.days ->
        "#{state.days}"

      state.hours && state.minutes && state.seconds ->
        "#{state.hours}, #{state.minutes} and #{state.seconds}"

      state.hours && state.minutes ->
        "#{state.hours} and #{state.minutes}"

      state.hours && state.seconds ->
        "#{state.hours} and #{state.seconds}"

      state.hours ->
        "#{state.hours}"

      state.minutes && state.seconds ->
        "#{state.minutes} and #{state.seconds}"

      state.minutes ->
        "#{state.minutes}"

      state.seconds ->
        state.seconds
    end
  end

  def parse_seconds(%DurationFormatter{total_count: seconds} = state) when seconds >= 31536000 do
    parse_seconds(%DurationFormatter{
      state
      | years: "#{div(seconds, 31536000)} year#{pluralize(div(seconds, 31536000))}",
        total_count: state.total_count - div(seconds, 31536000) * 31536000
    })
  end

  def parse_seconds(%DurationFormatter{total_count: seconds} = state) when seconds >= 86400 do
    parse_seconds(%DurationFormatter{
      state
      | days: "#{div(seconds, 86400)} day#{pluralize(div(seconds, 86400))}",
        total_count: state.total_count - div(seconds, 86400) * 86400
    })
  end

  def parse_seconds(%DurationFormatter{total_count: seconds} = state) when seconds >= 3600 do
    parse_seconds(%DurationFormatter{
      state
      | hours: "#{div(seconds, 3600)} hour#{pluralize(div(seconds, 3600))}",
        total_count: state.total_count - div(seconds, 3600) * 3600
    })
  end

  def parse_seconds(%DurationFormatter{total_count: seconds} = state) when seconds >= 60 do
    parse_seconds(%DurationFormatter{
      state
      | minutes: "#{div(seconds, 60)} minute#{pluralize(div(seconds, 60))}",
        total_count: state.total_count - div(seconds, 60) * 60
    })
  end

  def parse_seconds(%DurationFormatter{total_count: seconds} = state) when seconds > 0 do
    parse_seconds(%DurationFormatter{
      state
      | seconds: "#{seconds} second#{pluralize(seconds)}",
        total_count: state.total_count - seconds
    })
  end

  def pluralize(num), do: if(num > 1, do: "s", else: "")
end
