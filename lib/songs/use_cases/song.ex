defmodule Songs.UseCases.Song do
  import Ecto.Query, warn: false
  alias Songs.Repo

  alias Songs.Songs

  def list_songs do
    Repo.all(from(v in Songs, order_by: [asc: v.id]))
  end

  def create_song(attrs \\ %{}) do
    %Songs{}
    |> Songs.changeset(attrs)
    |> Repo.insert()
  end

  def delete_song(%Songs{} = song) do
    Repo.delete(song)
  end

  def change_song(%Songs{} = song, attrs \\ %{}) do
    Songs.changeset(song, attrs)
  end
end
