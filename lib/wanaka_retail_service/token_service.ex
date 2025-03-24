defmodule WanakaRetailService.TokenService do
  @moduledoc """
  This module is responsible for handling token related tasks.
  """
  alias WanakaRetailService.RestService

  def generate_token do

    url = "http://localhost:3000/api/wanaka/token"
    headers = ["x-client-id": "wanaka-budget",
          "x-client-secret": "ae7a79e3-c2bf-43c3-a339-c27b6ed0cd39",
          "x-grant-type": "api-user",
          "content-type": "Application/json"]

    RestService.get(url, headers)
  end

  def validate_token(token) do

    url = "http://localhost:3000/api/wanaka/token/validate"
    headers = ["x-client-id": "wanaka-budget", "Authorization": "Bearer #{token}", "content-type": "Application/json"]

    RestService.get(url, headers)
  end
end
