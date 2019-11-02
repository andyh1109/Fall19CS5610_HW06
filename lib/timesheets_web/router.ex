defmodule TimesheetsWeb.Router do
  use TimesheetsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug TimesheetsWeb.Plugs.FetchCurrentUser
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimesheetsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sheets",SheetController,
       only: [:new, :create, :index, :show, :update, :edit]   

    resources "/tasks", TaskController,
	    only: [:new, :create]
      
    resources "/users", UserController,
      only: [:new, :create, :show, :index]
      
    resources "/sessions", SessionController, 
      only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetsWeb do
  #   pipe_through :api
  # end
end
