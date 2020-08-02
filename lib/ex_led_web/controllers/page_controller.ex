defmodule ExLedWeb.PageController do
  use ExLedWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
