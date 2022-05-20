defmodule VigilantPalmTree.Repo do
  use Ecto.Repo,
    otp_app: :vigilant_palm_tree,
    adapter: Ecto.Adapters.Postgres
end
