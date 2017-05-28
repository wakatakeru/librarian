defmodule Librarian.BookController do
  use Librarian.Web, :controller

  def index(conn, _params) do
    books = Repo.all(Librarian.Book)
    render conn, "index.html", books: books
  end

  def show(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    render conn, "show.html", book: book
  end

  def new(conn, _params) do
    book  = Librarian.Book.changeset(%Librarian.Book{}, %{})
    genre = Repo.all(Librarian.Genre)
    render conn, "new.html", book: book, genre: genre
  end

  def create(conn, _params) do
    book = Librarian.Book.changeset(%Librarian.Book{}, _params["book"])
    Repo.insert(book)
    redirect conn, to: "/books"
  end

  def edit(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    genre = Repo.all(Librarian.Genre)
    render conn, "edit.html", book: book, genre: genre
  end

  def update(conn, _params) do
    book = Librarian.Book.changeset(%Librarian.Book{}, _params["book"])
    Repo.update(book)
    redirect conn, to: "/books"
  end

  def delete(conn, _params) do
    book = Repo.get(Librarian.Book, _params["id"])
    Repo.delete(book)
    redirect conn, to: "/books"
  end
end
