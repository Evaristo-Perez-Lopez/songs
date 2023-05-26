defmodule Songs.Repo do
  use Ecto.Repo,
    otp_app: :songs,
    adapter: Ecto.Adapters.MyXQL
end
