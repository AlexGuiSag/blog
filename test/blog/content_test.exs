defmodule Blog.ContentTest do
  use Blog.DataCase

  alias Blog.Content

  describe "posts" do
    alias Blog.Content.Post

    @valid_attrs %{body: "some body", email: "some email", name: "some name", title: "some title"}
    @update_attrs %{
      body: "some updated body",
      email: "some updated email",
      name: "some updated name",
      title: "some updated title"
    }
    @invalid_attrs %{body: nil, email: nil, name: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Content.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Posts.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.email == "some email"
      assert post.name == "some name"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Posts.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.email == "some updated email"
      assert post.name == "some updated name"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_attrs)
      assert post == Content.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Content.change_post(post)
    end
  end

  describe "categories" do
    alias Blog.Content.Category

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Content.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Content.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Content.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Content.update_category(category, @update_attrs)
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_category(category, @invalid_attrs)
      assert category == Content.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Content.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Content.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Content.change_category(category)
    end
  end
end
