defmodule HeadsUp.UrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HeadsUp.Urls` context.
  """

  @doc """
  Generate a unique url link.
  """
  def unique_url_link, do: "some link#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique url title.
  """
  def unique_url_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        link: unique_url_link(),
        title: unique_url_title()
      })
      |> HeadsUp.Urls.create_url()

    url
  end
end
