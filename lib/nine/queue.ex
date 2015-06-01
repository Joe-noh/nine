defmodule Nine.Queue do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, :queue.new}
  end

  @spec enqueue(term) :: no_return
  def enqueue(item) do
    GenServer.cast(__MODULE__, {:enqueue, item})
  end

  @spec dequeue :: {:ok, term} | {:error, :empty}
  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
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
