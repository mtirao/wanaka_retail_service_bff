defmodule WanakaRetailServiceWeb.ProfileController do

  alias WanakaRetailService.TokenService, as: TokenService
  alias WanakaRetailService.ProfileService, as: ProfileService
  alias WanakaRetailService.AuthService, as: AuthService
  use WanakaRetailServiceWeb, :controller
  require Logger

  def profile(conn, %{"user_id" => id}) do
    IO.puts("Token: #{get_req_header(conn, "authorization")}")
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok, _body} <- TokenService.validate_token(token),
        {:ok, body} <- AuthService.validate_authorization(id, "/api/wanaka/profile"),
        {:ok, profile} <- ProfileService.get_profile(id) do
      IO.puts("Token: #{token}")
      if body["userread"] == 1 do
        conn
        |> put_status(:ok)
        |> render("ok.json", %{body: profile})
      else
        conn
        |> put_status(:unauthorized)
        |> render("error.json", %{error: "Unauthorized"})
      end
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", %{error: "Unauthorized"})
    end
  end

end
