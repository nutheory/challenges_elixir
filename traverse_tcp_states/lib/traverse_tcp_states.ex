defmodule TraverseTcpStates do
  def traverse(event_list) do
    machine("CLOSED", event_list)
  end

  defp machine(state, events) when length(events) === 0 do
    state
  end

  defp machine(state, [head | tail]) when state === "CLOSED" do
    case head do
      "APP_ACTIVE_OPEN" -> machine("SYN_SENT", tail)
      "APP_PASSIVE_OPEN" -> machine("LISTEN", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "SYN_SENT" do
    case head do
      "RCV_SYN_ACK" -> machine("ESTABLISHED", tail)
      "RCV_SYN" -> machine("SYN_RCVD", tail)
      "APP_CLOSE" -> machine("CLOSED", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "LISTEN" do
    case head do
      "RCV_SYN" -> machine("SYN_RCVD", tail)
      "APP_SEND" -> machine("SYN_SENT", tail)
      "APP_CLOSE" -> machine("CLOSED", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "SYN_RCVD" do
    case head do
      "RCV_ACK" -> machine("ESTABLISHED", tail)
      "APP_CLOSE" -> machine("FIN_WAIT_1", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "ESTABLISHED" do
    case head do
      "RCV_FIN" -> machine("CLOSE_WAIT", tail)
      "APP_CLOSE" -> machine("FIN_WAIT_1", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "FIN_WAIT_1" do
    case head do
      "RCV_FIN" -> machine("CLOSING", tail)
      "RCV_FIN_ACK" -> machine("TIME_WAIT", tail)
      "RCV_ACK" -> machine("FIN_WAIT_2", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "FIN_WAIT_2" do
    case head do
      "RCV_FIN" -> machine("TIME_WAIT", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "CLOSING" do
    case head do
      "RCV_ACK" -> machine("TIME_WAIT", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "CLOSE_WAIT" do
    case head do
      "APP_CLOSE" -> machine("LAST_ACK", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "LAST_ACK" do
    case head do
      "RCV_ACK" -> machine("CLOSED", tail)
      _ -> machine("ERROR", [])
    end
  end

  defp machine(state, [head | tail]) when state === "TIME_WAIT" do
    machine("CLOSED", tail)
  end

  defp machine(_, _) do
    machine("ERROR", [])
  end
end
