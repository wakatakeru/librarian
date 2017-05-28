defmodule Librarian.Genre do
  use Librarian.Web, :model

  schema "genres" do
    field :name, :string

    has_many :books, Librarian.Book, on_delete: :delete_all
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
