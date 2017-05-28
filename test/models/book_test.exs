defmodule Librarian.BookTest do
  use Librarian.ModelCase

  alias Librarian.Book

  @valid_attrs %{isbn: 42, store_loc: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book.changeset(%Book{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book.changeset(%Book{}, @invalid_attrs)
    refute changeset.valid?
  end
end
