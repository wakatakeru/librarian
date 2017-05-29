defmodule Librarian.Book do
  use Librarian.Web, :model

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :store_loc, :string

    belongs_to :genre, Librarian.Genre, foreign_key: :genre_id
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :store_loc, :genre_id])
    |> validate_required([:title, :isbn, :store_loc, :genre_id])
    |> unique_constraint(:isbn)
  end
end
