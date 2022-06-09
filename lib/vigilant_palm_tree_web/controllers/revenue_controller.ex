defmodule VigilantPalmTreeWeb.RevenueController do
  use VigilantPalmTreeWeb, :controller

  alias VigilantPalmTree.Item
  alias VigilantPalmTree.Item.Revenue
  alias VigilantPalmTree.Accounts

  def index(conn, _params) do
    revenues = Item.list_revenues()
    render(conn, "index.html", revenues: revenues)
  end

  def new(conn, _params) do
    changeset = Item.change_revenue(%Revenue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"revenue" => revenue_params}) do
    user = conn
    |> get_session(:user_token)
    |> Accounts.get_user_by_session_token
    new_params = Map.put(revenue_params, "user_id", user.id)

    case Item.create_revenue(new_params) do
      {:ok, revenue} ->
        conn
        |> put_flash(:info, "Revenue created successfully.")
        |> redirect(to: Routes.revenue_path(conn, :show, revenue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    revenue = Item.get_revenue!(id)
    render(conn, "show.html", revenue: revenue)
  end

  def edit(conn, %{"id" => id}) do
    revenue = Item.get_revenue!(id)
    changeset = Item.change_revenue(revenue)
    render(conn, "edit.html", revenue: revenue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "revenue" => revenue_params}) do
    revenue = Item.get_revenue!(id)

    IO.inspect(revenue_params)

    case Item.update_revenue(revenue, revenue_params) do
      {:ok, revenue} ->
        conn
        |> put_flash(:info, "Revenue updated successfully.")
        |> redirect(to: Routes.revenue_path(conn, :show, revenue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", revenue: revenue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    revenue = Item.get_revenue!(id)
    {:ok, _revenue} = Item.delete_revenue(revenue)

    conn
    |> put_flash(:info, "Revenue deleted successfully.")
    |> redirect(to: Routes.revenue_path(conn, :index))
  end
end
