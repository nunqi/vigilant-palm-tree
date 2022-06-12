defmodule VigilantPalmTreeWeb.ExpenseController do
  use VigilantPalmTreeWeb, :controller

  alias VigilantPalmTree.Item
  alias VigilantPalmTree.Item.Expense
  alias VigilantPalmTree.Accounts

  def index(conn, _params) do
    expenses = Item.list_expenses(conn.assigns.current_user.id)
    render(conn, "index.html", expenses: expenses)
  end

  def new(conn, _params) do
    changeset = Item.change_expense(%Expense{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"expense" => expense_params}) do
    user = conn
    |> get_session(:user_token)
    |> Accounts.get_user_by_session_token
    new_params = Map.put(expense_params, "user_id", user.id)

    case Item.create_expense(new_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense created successfully.")
        |> redirect(to: Routes.expense_path(conn, :show, expense))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Item.get_expense!(id)
    render(conn, "show.html", expense: expense)
  end

  def edit(conn, %{"id" => id}) do
    expense = Item.get_expense!(id)
    changeset = Item.change_expense(expense)
    render(conn, "edit.html", expense: expense, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Item.get_expense!(id)

    case Item.update_expense(expense, expense_params) do
      {:ok, expense} ->
        conn
        |> put_flash(:info, "Expense updated successfully.")
        |> redirect(to: Routes.expense_path(conn, :show, expense))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expense: expense, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Item.get_expense!(id)
    {:ok, _expense} = Item.delete_expense(expense)

    conn
    |> put_flash(:info, "Expense deleted successfully.")
    |> redirect(to: Routes.expense_path(conn, :index))
  end
end
