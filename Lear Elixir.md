## Listas

- Módulo List

x = [1, 2, 3, 4]
y = [5, 6, 7, 8]
z = [1, 2, 7, 8]

hd x -> 1
tl x -> 4
[99 | x] -> [99, 1, 2, 3, 4]
x ++ y -> [1, 2, 3, 4, 5, 6, 7, 8]
y ++ y -> [5, 6, 7, 8, 1, 2, 3, 4]
x -- z -> [3, 4]
y -- z -> [5, 6]
z -- x -> [7, 8]
z -- y -> [1, 2]

## Tuplas

- Módulo Tuple

x = {1, 2, 3, 4}
elem(x, 0) -> 1
elem(x, 1) -> 2
elem(x, 2) -> 3
elem(x, 3) -> 4

## Keywords Lists

x = [{:first_name, "Luiz"}, {:last_name, "Felippe"}]
x -> [first_name: "Luiz", last_name: "Felippe"]

## Maps

- Módulo Map

!! Cuidado ao usar atom como key, já que no Elixir os atoms são limitados

x = %{first_name: "Luiz", last_name: "Felippe"}
x[:first_name] -> Luiz
x[:last_name] -> Felippe
%{x | last_name: "Silva"} -> %{first_name: "Luiz", last_name: "Silva"}

## Enums

- Módulo Enum

x = [1, 6, 7, 3, 9]
Enum.sort(x) -> [1, 3, 6, 7, 9]
Enum.sort(x, :desc) -> [9, 7, 6, 3, 1]
Enum.map(x, fn elem -> elem + 1 end) -> [2, 7, 8, 4, 10]

y = %{a: 1, b: 2}
Enum.reduce(y, %{}, fn {key, value}, acc -> Map.put(acc, key, value + 1) end) -> %{a: 2, b: 3}

## Pattern Matching

x = 3
x -> 3

[x, y, z] = [1, 2, 3]
x -> 1
y -> 2
z -> 3

[head | tail] = [1, 2, 3, 4, 5]
head -> 1
tail -> [2, 3, 4, 5]

%{a: x, b: y} = %{a: 1, b: 2}
x -> 1
y -> 2

{:ok, result} = {:ok, "Success"}
result -> "Success"

example_function = fn
{:ok, result} -> "O resultado foi: #{result}"
{:error, reason} -> "Deu ruim: #{reason}"
end

example_function.({:ok, "Resultado"}) -> "Deu ruim: Resultado"
example_function.({:error, "Resultado errado"}) -> "Deu ruim: Resultado errado"

## Pipe Operator

x = "LuiZ "
x |> String.trim() |> String.downcase() -> "luiz"

y = "AF3"
y |> String.trim() |> String.to_integer(16) -> 2803

## Files

- Módulo File

touch "teste.txt""
vim teste.txt
"Thaíssa é foda!"

File.read("teste.txt") -> {:ok, "Thaíssa é Foda!"}
File.read("teste.tx") -> {:error, :enoent}
