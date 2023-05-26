defmodule Songs.Songs do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field(:times, :integer)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(songs, attrs) do
    songs
    |> cast(attrs, [:title, :times])
    |> validate_required([:title, :times])
    |> validate_length(:title,
      min: 3,
      max: 50,
      message: "Title must be between 3 and 50 characters"
    )
    |> validate_number(:times, greater_than_or_equal_to: 0)
    |> validate_format(:title, ~r/^[a-zA-Z ]+$/, message: "Only letters and spaces allowed")
  end
end
