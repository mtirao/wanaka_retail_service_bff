defmodule WanakaRetailServiceWeb.AuthController do

  use WanakaRetailServiceWeb, :controller
  require Logger

  def login(conn, _params) do
    render(conn, "applications.json", %{applications: "app"})
  end

end
