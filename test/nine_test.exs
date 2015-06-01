defmodule NineTest do
  use ExUnit.Case

  test "integration" do
    Nine.Queue.enqueue({Kernel, :send, [self, :one]})
    Nine.Queue.enqueue({Kernel, :send, [self, :two]})
    Nine.Queue.enqueue({Kernel, :send, [self, :three]})

    assert_receive :one
    assert_receive :two
    assert_receive :three
  end
end
