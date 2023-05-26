defmodule SongsWeb.SongsController do
  use SongsWeb, :controller

  def index(conn, _params) do
    # send_resp(conn, 200, "Hello, world!")
    render(conn, :index, layout: false)
  end
end
