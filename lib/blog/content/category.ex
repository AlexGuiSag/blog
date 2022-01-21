defmodule Blog.Content.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.Post

  schema "categories" do
    field :description, :string
    field :name, :string

  has_many :posts, Post
  timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
