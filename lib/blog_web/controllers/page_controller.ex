defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def comment(conn, _params) do
    render(conn, :comment)
  end
end
