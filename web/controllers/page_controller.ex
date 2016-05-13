defmodule Props.PageController do
  use Props.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
