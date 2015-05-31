defmodule Nine.WorkerSup do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    workers = []
    opts = [strategy: :simple_one_for_one, name: __MODULE__]

    #supervise(workers, opts)
  end

  def run do
    Supervisor.start_child(__MODULE__, worker(Nine.Worker, [1000]))
  end
end
