defmodule VigilantPalmTree.Item.Revenue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "revenues" do
    field :title, :string
    field :value, :decimal
    #field :user_id, :id

    belongs_to :user, VigilantPalmTree.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(revenue, attrs) do
    revenue
    |> cast(attrs, [:title, :value, :user_id])
    |> validate_required([:title, :value, :user_id])
  end
end
