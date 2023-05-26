defmodule Songs.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :title, :string
      add :times, :integer

      timestamps()
    end
  end
end
