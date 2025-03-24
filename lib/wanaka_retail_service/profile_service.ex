defmodule WanakaRetailService.ProfileService do

  alias WanakaRetailService.RestService

  def get_profile(user_id) do

    url = "http://localhost:3002/api/wanaka/profile/#{user_id}"
    headers = ["content-type": "Application/json"]

    RestService.get(url, headers)

  end

end
