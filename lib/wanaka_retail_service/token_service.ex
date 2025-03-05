defmodule WanakaRetailService.TokenService do
  @moduledoc """
  This module is responsible for handling token related tasks.
  """

  def generate_token do

    url = "http://localhost:3000/api/wanaka/token"
    headers = ["x-client-id": "wanaka-budget",
          "x-client-secret": "ae7a79e3-c2bf-43c3-a339-c27b6ed0cd39",
          "x-grant-type": "api-user",
          "content-type": "Application/json"]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Bad request"}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:ok, %HTTPoison.Response{status_code: 401}} ->
        {:error, "Not authorized"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      _ ->
        {:error, "Unknown error"}
    end
  end

  def validate_token(token) do

    url = "http://localhost:3000/api/wanaka/token/validate"
    headers = ["x-client-id": "wanaka-budget", "Authorization": "Bearer #{token}", "content-type": "Application/json"]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Bad request"}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:ok, %HTTPoison.Response{status_code: 401}} ->
        {:error, "Not authorized"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      _ ->
        {:error, "Unknown error"}
    end
  end
end
