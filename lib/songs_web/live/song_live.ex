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
     <.flash_group flash={@flash} />
    <h1 class="font-bold text-xl text-center text-sky-700 p-3">Songs</h1>
    <.form class="p-3 border-2 rounded mb-3" for={@form} phx-submit="save">
      <.input field={@form[:title]} placeholder="Enter a title" autocomplete="off" />
      <.input
        field={@form[:times]}
        type="number"
        placeholder="Enter times you heard it"
        autocomplete="off"
      />
      <.button class="mt-3" type="submit" phx-disable-with="Saving...">Save</.button>
    </.form>
    <%= if @songs == [] do %>
      <p class="text-center text-gray-500">No songs yet</p>
    <% end %>
      <%= for song <- @songs do %>
        <.songcard title={song.title} times={song.times} />
      <% end %>
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
  def songcard(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto py-2 box-border px-2 bg-gray-50 mb-2">
      <h2 class="font-bold text-lg text-sky-600 py-3 border-b-2"><%= @title %></h2>
      <p class="text-base text-gray-500 ">Heard <%= @times %> times</p>
    </div>
    """
  end
end
