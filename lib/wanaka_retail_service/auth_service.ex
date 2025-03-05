defmodule WanakaRetailService.AuthService do
  @moduledoc """
  This module is responsible for handling authentication related tasks.
  """

  def login(token) do

    url = "http://localhost:3001/api/wanaka/accounts/login"
    headers = ["Authorization": "#{token}", "content-type": "Application/json"]

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

  def validate_authorization(userid, resource) do

    url = "http://localhost:3004/api/wanaka/authorize"
    headers = ["content-type": "Application/json"]
    body = Jason.encode!(%{"userid" => userid, "resource" => resource})

    case HTTPoison.post(url, body, headers) do
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
