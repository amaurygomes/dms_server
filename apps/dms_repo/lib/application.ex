defmodule DmsRepo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      DmsRepo
    ]

    opts = [strategy: :one_for_one, name: DmsRepo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
