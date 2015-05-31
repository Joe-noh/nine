defmodule Nine.Queue do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :queue.new, opts)
  end

  @spec enqueue(atom, term) :: no_return
  def enqueue(pid, item) do
    GenServer.cast(pid, {:enqueue, item})
  end

  @spec dequeue(atom) :: {:ok, term} | {:error, :empty}
  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  def handle_cast({:enqueue, item}, q) do
    {:noreply, :queue.in(item, q)}
  end

  def handle_call(:dequeue, _from, q) do
    case :queue.out(q) do
      {:empty, q} -> {:reply, {:error, :empty}, q}
      {{:value, item}, q} -> {:reply, {:ok, item}, q}
    end
  end
end
