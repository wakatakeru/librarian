defmodule Librarian.Router do
  use Librarian.Web, :router

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

  scope "/", Librarian do
    pipe_through :browser # Use the default browser stack

    get "/", BookController, :index
    resources "/genres", GenreController
    resources "/books",  BookController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Librarian do
  #   pipe_through :api
  # end
end
