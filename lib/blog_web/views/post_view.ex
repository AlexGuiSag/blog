defmodule BlogWeb.PostView do
  use BlogWeb, :view

  alias Blog.Content

  def get_comments_count(post_id) do
		Content.get_number_of_comments(post_id)
	end
end
