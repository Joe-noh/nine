defmodule QueueTest do
  use ExUnit.Case

  test "enqueue" do
    Nine.Queue.enqueue(1)
    Nine.Queue.enqueue(2)
    Nine.Queue.enqueue(3)

    assert Nine.Queue.dequeue == {:ok, 1}
    assert Nine.Queue.dequeue == {:ok, 2}
    assert Nine.Queue.dequeue == {:ok, 3}

    assert Nine.Queue.dequeue == {:error, :empty}
  end
end
