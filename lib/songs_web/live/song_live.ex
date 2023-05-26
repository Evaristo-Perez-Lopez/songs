defmodule SongsWeb.SongLive do
  use SongsWeb, :live_view
  alias Songs.UseCases.Song
  alias Songs.Songs

  def mount(_params, _session, socket) do
    songs = Song.list_songs()
    changeset = Song.change_song(%Songs{})
    form = to_form(changeset)
    socket = assign(socket, songs: songs, form: form)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Songs</h1>
     <.flash_group flash={@flash} />
    <pre>
    <%= inspect(@songs, pretty: true) %>
    </pre>
    <.form for={@form} phx-submit="save">
      <.input field={@form[:title]} placeholder="Enter a title" autocomplete="off" />
      <.input
        field={@form[:times]}
        type="number"
        placeholder="Enter times you heard it"
        autocomplete="off"
      />
      <.button type="submit" phx-disable-with="Saving...">Save</.button>
    </.form>

    <pre>
    <%= inspect(@form, pretty: true) %>
    </pre>
    """
  end

  def handle_event("save", %{"songs" => song_params}, socket) do
    case Song.create_song(song_params) do
      {:ok, song} ->
        socket = update(socket, :songs, fn songs -> [song | songs] end)
        changeset = Song.change_song(%Songs{})
        socket = put_flash(socket, :info, "Song created successfully.")
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, changeset} ->
        socket = put_flash(socket, :error, "Something went wrong")
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
