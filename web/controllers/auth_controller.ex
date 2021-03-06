require IEx

defmodule Props.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Props.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Props.User
  alias Props.Repo

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    changeset = User.changeset(%User{}, auth.extra.raw_info.user)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: Props.Router.Helpers.props_path(Props.Endpoint, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
