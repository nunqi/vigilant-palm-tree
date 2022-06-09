defmodule VigilantPalmTree.ItemFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VigilantPalmTree.Item` context.
  """

  @doc """
  Generate a expense.
  """
  def expense_fixture(attrs \\ %{}) do
    {:ok, expense} =
      attrs
      |> Enum.into(%{
        title: "some title",
        value: "120.5"
      })
      |> VigilantPalmTree.Item.create_expense()

    expense
  end

  @doc """
  Generate a revenue.
  """
  def revenue_fixture(attrs \\ %{}) do
    {:ok, revenue} =
      attrs
      |> Enum.into(%{
        title: "some title",
        value: "120.5"
      })
      |> VigilantPalmTree.Item.create_revenue()

    revenue
  end
end
