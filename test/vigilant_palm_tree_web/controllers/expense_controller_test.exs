defmodule VigilantPalmTreeWeb.ExpenseControllerTest do
  use VigilantPalmTreeWeb.ConnCase

  import VigilantPalmTree.ItemFixtures

  @create_attrs %{title: "some title", value: "120.5"}
  @update_attrs %{title: "some updated title", value: "456.7"}
  @invalid_attrs %{title: nil, value: nil}

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, Routes.expense_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Expenses"
    end
  end

  describe "new expense" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.expense_path(conn, :new))
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "create expense" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.expense_path(conn, :show, id)

      conn = get(conn, Routes.expense_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Expense"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expense"
    end
  end

  describe "edit expense" do
    setup [:create_expense]

    test "renders form for editing chosen expense", %{conn: conn, expense: expense} do
      conn = get(conn, Routes.expense_path(conn, :edit, expense))
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "redirects when data is valid", %{conn: conn, expense: expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @update_attrs)
      assert redirected_to(conn) == Routes.expense_path(conn, :show, expense)

      conn = get(conn, Routes.expense_path(conn, :show, expense))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expense"
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete(conn, Routes.expense_path(conn, :delete, expense))
      assert redirected_to(conn) == Routes.expense_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.expense_path(conn, :show, expense))
      end
    end
  end

  defp create_expense(_) do
    expense = expense_fixture()
    %{expense: expense}
  end
end
