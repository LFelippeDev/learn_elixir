defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = "35523220"

      body = ~s({
          "bairro": "Fausto Pinto da Fonseca I",
          "cep": "35523-220",
          "complemento": "",
          "ddd": "37",
          "gia": "",
          "ibge": "3145208",
          "localidade": "Nova Serrana",
          "logradouro": "Rua Dionísio Rabelo",
          "siafi": "4903",
          "uf": "MG"
        })

      expected_response =
        {:ok,
         %{
           "bairro" => "Fausto Pinto da Fonseca I",
           "cep" => "35523-220",
           "complemento" => "",
           "ddd" => "37",
           "gia" => "",
           "ibge" => "3145208",
           "localidade" => "Nova Serrana",
           "logradouro" => "Rua Dionísio Rabelo",
           "siafi" => "4903",
           "uf" => "MG"
         }}

      Bypass.expect(bypass, "GET", "/35523220/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
