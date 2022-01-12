defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  #alias Blog.Repo
  alias Blog.Content
  alias Blog.Content.Post
  alias Blog.Social.Comment


def create(conn, %{"comment" => comment_params}) do
  case Social.create_comment(comment_params) do
    {:ok, post} ->
      conn
      |> put_flash(:info, "Comment created successfully.")
      |> redirect(to: Routes.post_path(conn, :show, post))

    #{:error, %Ecto.Changeset{} = changeset} ->
     # render(conn, "new.html", changeset: changeset)
  end
end
def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
  post =
    post_id
    |> Content.get_post!()
  #  |> Repo.preload([:comments])
  case Social.add_comment(post_id, comment_params) do
    {:ok, _comment} ->
      conn
      |> put_flash(:info, "Added comment!")
      |> redirect(to: Routes.post_path(conn, :show, post))
    {:error, _error} ->
      conn
      |> put_flash(:error, "Oops! Couldn't add comment!")
      |> redirect(to: Routes.post_path(conn, :show, post))
  end
end

end
