defmodule AmigoBackend.Repo do
  use Ecto.Repo,
    otp_app: :amigo_backend,
    adapter: Ecto.Adapters.Postgres
end
