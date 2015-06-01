defmodule Nine.Dispatcher do
  use GenServer

  defmodule State do
    defstruct num_workers: 0
  end

  alias State, as: S

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [opts], name: __MODULE__)
  end

  def init(_) do
    {:ok, %S{}}
  end

  def spawn({mod, fun, args}) do
    GenServer.cast(__MODULE__, {:spawn, mod, fun, args})
  end

  def count_workers do
    GenServer.call(__MODULE__, :count_workers)
  end

  def handle_cast({:spawn, mod, fun, args}, s = %S{num_workers: num}) do
    spawn_monitor(mod, fun, args)
    {:noreply, %S{s | num_workers: num+1}}
  end

  def handle_call(:count_workers, _from, s = %S{num_workers: num}) do
    {:reply, num, s}
  end

  def handle_info({:DOWN, _ref, :process, _pid, :normal}, s = %S{num_workers: num}) do
    {:noreply, %S{s | num_workers: num-1}}
  end

  def handle_info(msg, state) do
    IO.inspect msg
    {:noreply, state}
  end
end

