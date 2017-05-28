defmodule Librarian.Book do
  use Librarian.Web, :model

  schema "books" do
    field :title, :string
    field :isbn, :integer
    field :store_loc, :string

    belongs_to :genre, Librarian.Genre, foreign_key: :genre_id
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :isbn, :store_loc])
    |> validate_required([:title, :isbn, :store_loc])
    |> unique_constraint(:isbn)
  end
end
