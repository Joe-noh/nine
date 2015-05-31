defmodule Nine.Worker do
  @moduledoc """
  This module represents a job worker
  """

  use GenServer

  def start_link(ms) do
    GenServer.start_link(__MODULE__, [])
  end
end
