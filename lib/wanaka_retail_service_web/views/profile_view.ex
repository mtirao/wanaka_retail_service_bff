defmodule WanakaRetailServiceWeb.ProfileJSON do
  ##use WanakaRetailServiceWeb, :view

  def render("ok.json", %{body: result}) do
   result
  end

  def render("error.json", %{error: result}) do
    %{message: result}
   end

end
