defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Social.Comment

  schema "posts" do
    field :body, :string
    field :email, :string
    field :name, :string
    field :title, :string

    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :name, :email])
    |> validate_required([:title, :body, :name, :email])
  end
end
