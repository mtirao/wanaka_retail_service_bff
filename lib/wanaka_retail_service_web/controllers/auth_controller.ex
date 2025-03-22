defmodule WanakaRetailServiceWeb.AuthController do

  alias WanakaRetailService.AuthService, as: AuthService
  alias WanakaRetailService.TokenService, as: TokenService
  use WanakaRetailServiceWeb, :controller
  require Logger

  def login(conn, _params) do
    authorization = get_req_header(conn, "authorization")
    case TokenService.generate_token() do
      {:ok, token} ->
        case AuthService.login(authorization) do
          {:ok, body} ->
            conn
            |> put_status(:ok)
            |> render("ok.json", %{body: Map.put(token, :userid, body["userid"])})
          {:error, reason} ->
            conn
            |> put_status(:unauthorized)
            |> render("error.json", %{error: reason})
        end
      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> render("error.json", %{error: reason})
    end
  end

end
