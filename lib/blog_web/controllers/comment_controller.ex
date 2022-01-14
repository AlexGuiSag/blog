defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Repo
  alias Blog.Social
  alias Blog.Content

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    attrs = comment_params |> Map.put("post_id", post_id)

    post =
      post_id
      |> Content.get_post!()
      |> Repo.preload([:comments])

    # Post = 1
    case Social.create_comment(attrs) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end
end
