defmodule Desafio01Relatorios.Parser do
  @months %{
    "1" => "01-Janeiro",
    "2" => "02-Fevereiro",
    "3" => "03-Março",
    "4" => "04-Abril",
    "5" => "05-Maio",
    "6" => "06-Junho",
    "7" => "07-Julho",
    "8" => "08-Agosto",
    "9" => "09-Setembro",
    "10" => "10-Outubro",
    "11" => "11-Novembro",
    "12" => "12-Dezembro"
  }

  def parse_file(file_name) do
    "arquivos/#{file_name}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.to_atom(&1))
    |> List.update_at(1, &String.to_integer(&1))
    |> List.update_at(3, &String.to_atom(Map.get(@months, &1)))
    |> List.update_at(4, &String.to_atom(&1))
  end
end
