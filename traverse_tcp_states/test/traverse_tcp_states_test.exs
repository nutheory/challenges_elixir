defmodule TraverseTcpStatesTest do
  use ExUnit.Case
  import TraverseTcpStates, only: [traverse: 1]
  doctest TraverseTcpStates

  test "should work for the sample examples" do
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN_ACK", "RCV_FIN"]) == "CLOSE_WAIT"
    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK"]) == "ESTABLISHED"
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN_ACK", "RCV_FIN", "APP_CLOSE"]) == "LAST_ACK"
    assert traverse(["APP_ACTIVE_OPEN"]) == "SYN_SENT"

    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_CLOSE", "APP_SEND"]) ==
             "ERROR"
  end

  test "should work for the examples" do
    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_CLOSE"]) == "FIN_WAIT_1"
    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK"]) == "ESTABLISHED"
    assert traverse(["APP_PASSIVE_OPEN"]) == "LISTEN"
    assert traverse(["APP_ACTIVE_OPEN", "APP_CLOSE"]) == "CLOSED"

    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN", "APP_CLOSE", "RCV_FIN", "RCV_ACK"]) ==
             "TIME_WAIT"

    assert traverse([
             "APP_ACTIVE_OPEN",
             "RCV_SYN",
             "APP_CLOSE",
             "RCV_FIN",
             "RCV_ACK",
             "APP_TIMEOUT"
           ]) == "CLOSED"

    assert traverse(["RCV_SYN", "RCV_ACK", "APP_CLOSE"]) == "ERROR"
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN", "APP_CLOSE", "RCV_ACK"]) == "FIN_WAIT_2"
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN_ACK", "RCV_FIN"]) == "CLOSE_WAIT"
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN_ACK", "RCV_FIN", "APP_CLOSE"]) == "LAST_ACK"
    assert traverse(["APP_ACTIVE_OPEN"]) == "SYN_SENT"
    assert traverse(["APP_PASSIVE_OPEN", "APP_CLOSE"]) == "CLOSED"
    assert traverse(["APP_ACTIVE_OPEN", "RCV_SYN_ACK", "APP_CLOSE"]) == "FIN_WAIT_1"
    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_PASSIVE_OPEN"]) == "ERROR"

    assert traverse([
             "APP_PASSIVE_OPEN",
             "RCV_SYN",
             "RCV_ACK",
             "APP_CLOSE",
             "RCV_FIN_ACK",
             "APP_TIMEOUT",
             "APP_ACTIVE_OPEN",
             "RCV_SYN",
             "APP_CLOSE",
             "RCV_FIN",
             "RCV_ACK"
           ]) == "TIME_WAIT"

    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_CLOSE", "RCV_SYN"]) == "ERROR"
    assert traverse(["APP_PASSIVE_OPEN", "APP_CLOSE", "RCV_SYN"]) == "ERROR"
    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_CLOSE"]) == "FIN_WAIT_1"

    assert traverse(["APP_PASSIVE_OPEN", "RCV_SYN", "RCV_ACK", "APP_CLOSE", "RCV_FIN"]) ==
             "CLOSING"
  end
end
