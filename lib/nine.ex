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
      worker(Nine.Manager, [opts_for_manager]),
      worker(Nine.Dispatcher, [[]]),
      worker(Nine.Queue, [opts_for_queue])
    ]

    opts = [strategy: :one_for_one, name: Nine.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp opts_for_manager do
    [max_workers: 5, interval: 2000]
  end

  defp opts_for_queue do
    []
  end
end
