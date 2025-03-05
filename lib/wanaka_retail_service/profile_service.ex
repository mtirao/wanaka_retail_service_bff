defmodule WanakaRetailService.ProfileService do

  def get_profile(user_id) do

    url = "http://localhost:3002/api/wanaka/profile/#{user_id}"
    headers = ["content-type": "Application/json"]

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
