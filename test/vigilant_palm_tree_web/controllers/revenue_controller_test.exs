defmodule VigilantPalmTreeWeb.RevenueControllerTest do
  use VigilantPalmTreeWeb.ConnCase

  import VigilantPalmTree.ItemFixtures

  @create_attrs %{title: "some title", value: "120.5"}
  @update_attrs %{title: "some updated title", value: "456.7"}
  @invalid_attrs %{title: nil, value: nil}

  describe "index" do
    test "lists all revenues", %{conn: conn} do
      conn = get(conn, Routes.revenue_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Revenues"
    end
  end

  describe "new revenue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.revenue_path(conn, :new))
      assert html_response(conn, 200) =~ "New Revenue"
    end
  end

  describe "create revenue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.revenue_path(conn, :create), revenue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.revenue_path(conn, :show, id)

      conn = get(conn, Routes.revenue_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Revenue"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.revenue_path(conn, :create), revenue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Revenue"
    end
  end

  describe "edit revenue" do
    setup [:create_revenue]

    test "renders form for editing chosen revenue", %{conn: conn, revenue: revenue} do
      conn = get(conn, Routes.revenue_path(conn, :edit, revenue))
      assert html_response(conn, 200) =~ "Edit Revenue"
    end
  end

  describe "update revenue" do
    setup [:create_revenue]

    test "redirects when data is valid", %{conn: conn, revenue: revenue} do
      conn = put(conn, Routes.revenue_path(conn, :update, revenue), revenue: @update_attrs)
      assert redirected_to(conn) == Routes.revenue_path(conn, :show, revenue)

      conn = get(conn, Routes.revenue_path(conn, :show, revenue))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, revenue: revenue} do
      conn = put(conn, Routes.revenue_path(conn, :update, revenue), revenue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Revenue"
    end
  end

  describe "delete revenue" do
    setup [:create_revenue]

    test "deletes chosen revenue", %{conn: conn, revenue: revenue} do
      conn = delete(conn, Routes.revenue_path(conn, :delete, revenue))
      assert redirected_to(conn) == Routes.revenue_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.revenue_path(conn, :show, revenue))
      end
    end
  end

  defp create_revenue(_) do
    revenue = revenue_fixture()
    %{revenue: revenue}
  end
end
