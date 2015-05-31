defmodule Nine do
  @moduledoc """
      (Sup)--+--(Dispatcher)
             |--(Manager)
             |--(Queue)
             +--(HTTPInterface)
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Nine.WorkerSup, [], name: Nine.WorkerSup),
      worker(Nine.Queue, [[name: Nine.Queue]])
    ]

    opts = [strategy: :one_for_one, name: Nine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
