defmodule Librarian.GenreController do
  use Librarian.Web, :controller

  def index(conn, _params) do
    genres = Repo.all(Librarian.Genre)
    render conn, "index.html", genres: genres
  end

  def show(conn, _params) do
    genre = Repo.preload(Repo.get(Librarian.Genre, _params["id"]), :books)
    books = genre.books
    render conn, "show.html", genre: genre, books: books
  end

  def new(conn, _params) do
    genre = Librarian.Genre.changeset(%Librarian.Genre{}, %{})
    render conn, "new.html", genre: genre
  end

  def create(conn, _params) do
    genre = Librarian.Genre.changeset(%Librarian.Genre{}, _params["genre"])
    case Repo.insert(genre)  do
      {:ok, genre} ->
        redirect conn, to: "/genres"
      {:error, genre} ->
        render(conn, "new.html", genre: genre)
    end
  end

  def edit(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    changeset = Librarian.Genre.changeset(genre)
    render conn, "edit.html", genre: genre, changeset: changeset
  end

  def update(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    changeset = Librarian.Genre.changeset(genre, _params["genre"])
    case Repo.insert(changeset)  do
      {:ok, genre} ->
        redirect conn, to: "/genres"
      {:error, chageset} ->
        render(conn, "edit.html", genre: genre)
    end
  end

  def delete(conn, _params) do
    genre = Repo.get(Librarian.Genre, _params["id"])
    Repo.delete_all(from(b in Librarian.Book, where: b.genre_id == ^genre.id))
    Repo.delete(genre)
    redirect conn, to: "/genres"
  end
end
