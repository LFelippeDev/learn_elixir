defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        name: "Felippe",
        email: "lfelippeeng@gmail.com",
        cep: "35523220",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "35523220", "email" => "lfelippeeng@gmail.com", "id" => _id, "name" => "Felippe"},
               "message" => "User criado com sucesso!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        email: "lfelippeeng",
        cep: "35",
        password: "1"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "cep" => ["should be at least 8 character(s)"],
          "name" => ["can't be blank"],
          "password" => ["should be at least 4 character(s)"],
          "email" => ["has invalid format"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        name: "Felippe",
        email: "lfelippeeng@gmail.com",
        cep: "35523220",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"cep" => "35523220", "email" => "lfelippeeng@gmail.com", "id" => id, "name" => "Felippe"}
      }

      assert response == expected_response
    end

    test "when there are invalid id, returns an error", %{conn: conn} do
      response =
        conn
        |> delete(~p"/api/users/1")
        |> json_response(:not_found)

      expected_response = %{"message" => "Uset not found", "status" => "not_found"}

      assert expected_response == response
    end
  end
end
