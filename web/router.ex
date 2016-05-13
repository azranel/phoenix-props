defmodule Props.Router do
  use Props.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Props.RedirectsPlug
  end

  scope "/", Props do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Props do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/props", Props do
    pipe_through [:browser, :authenticated]

    get "/", PropsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Props do
  #   pipe_through :api
  # end
end
