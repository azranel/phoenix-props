defmodule Props.PropsController do
  use Props.Web, :controller

  alias Props.Repo
  alias Props.Prop
  alias Props.User

  def index(conn, _params) do
    props = Prop |> Repo.all |> Repo.preload([:user, :propser])
    render conn, "index.html", props: props
  end
end
