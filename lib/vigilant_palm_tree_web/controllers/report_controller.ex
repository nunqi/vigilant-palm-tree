defmodule VigilantPalmTreeWeb.ReportController do
  use VigilantPalmTreeWeb, :controller

  alias VigilantPalmTree.Item

  def index(conn, _params) do
    expenses = Item.five_bigger_expenses(conn.assigns.current_user.id)
    revenues = Item.five_bigger_revenues(conn.assigns.current_user.id)
    render(conn, "index.html", expenses: expenses, revenues: revenues)
  end
end
