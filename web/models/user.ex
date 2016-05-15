defmodule Props.User do
  use Props.Web, :model

  schema "users" do
    field :email, :string
    field :last_name, :string
    field :first_name, :string
    field :picture, :string

    timestamps
  end

  @required_fields ~w(email last_name first_name picture)
  @optional_fields ~w()

  def name(user) do
    "#{user.first_name} #{user.last_name}"
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    new_params = params |>
      Map.put("last_name", Map.fetch!(params, "family_name")) |>
      Map.put("first_name", Map.fetch!(params, "given_name"))
    model
    |> cast(new_params, @required_fields, @optional_fields)
  end
end
