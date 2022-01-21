defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Repo
  alias Blog.Content
  alias Blog.Content.Post
  alias Blog.Social.Comment

  def index(conn, _params) do
    posts = Content.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category_id" => category_id, "params" => post_params}) do
    attrs = post_params |> Map.put("category_id", category_id)


      case Content.create_post(attrs) do
        {:ok, _create_post} ->
          conn
          |> put_flash(:info, "Post created successfully.")
          |> redirect(to: Routes.post_path(conn, :show, post_params))
      end
  end

  def show(conn, %{"id" => id}) do
    post =
      id
      |> Content.get_post!()
      |> Repo.preload([:comments])

    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    changeset = Content.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get_post!(id)

    case Content.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    {:ok, _post} = Content.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
