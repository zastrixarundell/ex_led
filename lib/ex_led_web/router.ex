defmodule ExLedWeb.Router do
  use ExLedWeb, :router

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

  scope "/", ExLedWeb do
    pipe_through :browser

    get "/", ControllerController, :index
    get "/:id", ControllerController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExLedWeb do
  #   pipe_through :api
  # end
end
