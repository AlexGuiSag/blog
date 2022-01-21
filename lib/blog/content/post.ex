defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Social.Comment

  schema "posts" do
    field :body, :string
    field :email, :string
    field :name, :string
    field :title, :string

    belongs_to(:categories, Blog.Content.Category)
    has_many :comments, Comment
    timestamps()



  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :name, :email, :category_id])
    |> validate_required([:title, :body, :name, :email, :category_id])
  end
end
