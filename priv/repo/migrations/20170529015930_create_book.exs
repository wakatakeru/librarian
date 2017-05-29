defmodule Librarian.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :isbn, :integer
      add :store_loc, :string
      add :genre_id, :integer

      timestamps()
    end
    create unique_index(:books, [:isbn])

  end
end
