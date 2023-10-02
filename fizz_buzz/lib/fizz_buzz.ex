defmodule FizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}) do
    result=
      result
      |> String.split(",")
      |> Enum.map(&covert_and_evaleate_numbers/1)
    {:ok, result}
  end
  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp covert_and_evaleate_numbers(elem) do
    elem
    |> String.to_integer()
    |> evaulate_numbers()
  end

  defp evaulate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: "fizzbuzz"
  defp evaulate_numbers(number) when rem(number, 5) == 0, do: "fizz"
  defp evaulate_numbers(number) when rem(number, 3) == 0, do: "buzz"
  defp evaulate_numbers(number), do: number
end
