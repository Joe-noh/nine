defmodule Nine.Manager do
  use GenServer

  defmodule State do
    defstruct interval: 2000, max_workers: 5, current_workers: 0
  end

  alias State, as: S

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    state = %S{
      interval:    Keyword.get(opts, :interval),
      max_workers: Keyword.get(opts, :max_workers)
    }
    Process.send_after self, :poll, state.interval
    {:ok, state}
  end

  def handle_info(:poll, state) do
    IO.puts "poll"

    Process.send_after self, :poll, state.interval
    {:noreply, state}
  end
end
