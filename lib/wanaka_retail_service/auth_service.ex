defmodule WanakaRetailService.AuthService do
  @moduledoc """
  This module is responsible for handling authentication related tasks.
  """
alias WanakaRetailService.RestService


  def login(token) do

    url = "http://localhost:3001/api/wanaka/accounts/login"
    headers = ["Authorization": "#{token}", "content-type": "Application/json"]

    RestService.get(url, headers)
  end

  def validate_authorization(userid, resource) do

    url = "http://localhost:3004/api/wanaka/authorize"
    headers = ["content-type": "Application/json"]
    body = Jason.encode!(%{"userid" => userid, "resource" => resource})

    RestService.post(url, body, headers)
  end

end
