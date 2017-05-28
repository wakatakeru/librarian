defmodule Librarian.GenreController do
  use Librarian.Web, :controller

  def index(conn, _params) do
    genres = Repo.all(Librarian.Genre)
    render conn, "index.html", genres: genres
  end

  def show(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    render conn, "show.html", genre: genre
  end

  def new(conn, _params) do
    genre = Librarian.Genre.changeset(%Librarian.Genre{}, %{})
    render conn, "new.html", genre: genre
  end

  def create(conn, _params) do
    genre = Librarian.Genre.changeset(%Librarian.Genre{}, _params["genre"])
    Repo.insert(genre)
    redirect conn, to: "/genres"
  end

  def edit(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    render conn, "edit.html", genre: genre
  end

  def update(conn, _params) do
    genre = Librarian.Genre.changeset(%Librarian.Genre{}, _params["genre"])
    Repo.update(genre)
    redirect conn, to: "/genres"
  end

  def delete(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    Repo.delete(genre)
    redirect conn, to: "/genres"
  end
end
