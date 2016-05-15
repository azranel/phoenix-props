
defmodule Props.PropsController do
  use Props.Web, :controller

  alias Props.Repo
  alias Props.Prop
  alias Props.User

  def index(conn, _params) do
    props = Prop |> Repo.all |> Repo.preload([:user, :propser])
    render conn, "index.html", props: props
  end

  def new(conn, _params) do
    changeset = Prop.changeset(%Prop{}, %{})
    render conn, "new.html", changeset: changeset, users_list: users_list
  end

  def create(conn, %{"prop" => prop_params}) do
    propser = get_session(conn, :current_user)
    changeset = Prop.changeset(%Prop{propser_id: propser.id, user_id: prop_params["user_id"]}, prop_params)
    case changeset.valid? do
      true ->
        Repo.insert(changeset)
        redirect conn, to: props_path(conn, :index)
      false ->
        render conn, "edit.html", changeset: changeset, errors: changeset.errors
    end
  end

  defp users_list do
    Repo.all(User) |>
      Enum.map(&{User.name(&1), &1.id})
  end
end
