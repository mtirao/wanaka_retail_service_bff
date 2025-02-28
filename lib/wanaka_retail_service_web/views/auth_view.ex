defmodule WanakaRetailServiceWeb.AuthJSON do
  ##use WanakaRetailServiceWeb, :view

  def render("applications.json", %{applications: app}) do
    %{applications: app}
  end

end
