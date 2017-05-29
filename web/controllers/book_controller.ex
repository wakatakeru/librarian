defmodule Librarian.BookController do
  use Librarian.Web, :controller

  def index(conn, _params) do
    books = Repo.all(Librarian.Book)
    render conn, "index.html", books: books
  end

  def show(conn, _params) do
    book  = Repo.preload(Repo.get(Librarian.Book, _params["id"]), :genre)
    render conn, "show.html", book: book
  end

  def new(conn, _params) do
    book  = Librarian.Book.changeset(%Librarian.Book{}, %{})
    genre = Enum.map(Repo.all(Librarian.Genre), &{&1.name, &1.id})
    render conn, "new.html", book: book, genre: genre
  end

  def create(conn, _params) do
    book = Librarian.Book.changeset(%Librarian.Book{}, _params["book"])
    case Repo.insert(book)  do
      {:ok, book} ->
        redirect conn, to: "/books"
      {:error, book} ->
        genre = Enum.map(Repo.all(Librarian.Genre), &{&1.name, &1.id})
        render(conn, "new.html", book: book, genre: genre)
    end
  end

  def edit(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    genre = Enum.map(Repo.all(Librarian.Genre), &{&1.name, &1.id})
    changeset = Librarian.Book.changeset(book)
    render conn, "edit.html", book: book, genre: genre, changeset: changeset
  end

  def update(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    changeset = Librarian.Book.changeset(book, _params["book"])
    case Repo.update(changeset) do
      {:ok, book} ->
        redirect conn, to: "/books"
      {:error, changeset} ->
        genre = Enum.map(Repo.all(Librarian.Genre), &{&1.name, &1.id})
        render(conn, "edit.html", book: book, changeset: changeset, genre: genre)
    end      
  end


  def delete(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    Repo.delete(book)
    redirect conn, to: "/books"
  end
end
