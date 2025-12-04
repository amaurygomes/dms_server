defmodule DmsRepo do
  use Ecto.Repo,
    otp_app: :dms_repo,
    adapter: Ecto.Adapters.Postgres
end
