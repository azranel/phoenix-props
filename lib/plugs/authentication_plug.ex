defmodule Props.RedirectsPlug do
  import Plug.Conn
  import Plug.Session

  def init(options), do: options

  def call(conn, options) do
    case get_session(conn, :current_user) do
      nil -> do_redirect(conn, "/")
      _ -> conn
    end
  end

  defp do_redirect(conn, to) do
    conn
      |> Phoenix.Controller.redirect(to: to)
      |> halt
  end
end
