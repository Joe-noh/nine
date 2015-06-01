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

  def handle_info(:poll, s) do
    if Nine.Dispatcher.count_workers < s.max_workers do
      dequeue |> dispatch
    end

    Process.send_after self, :poll, s.interval
    {:noreply, s}
  end

  defp dequeue do
    case Nine.Queue.dequeue do
      {:ok, task} -> task
      _ -> nil
    end
  end

  defp dispatch(nil), do: nil

  defp dispatch(mfa) when tuple_size(mfa) == 3 do
    Nine.Dispatcher.spawn(mfa)
  end
end
