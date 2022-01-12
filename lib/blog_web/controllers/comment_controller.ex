defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  #alias Blog.Repo
  alias Blog.Social


def create(conn, %{"comment" => comment_params}) do
  case Social.create_comment(comment_params) do
    {:ok, post} ->
      conn
      |> put_flash(:info, "Comment created successfully.")
      |> redirect(to: Routes.post_path(conn, :show, post))
  end
end

end
