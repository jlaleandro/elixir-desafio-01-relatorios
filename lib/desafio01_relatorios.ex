defmodule Desafio01Relatorios do
  alias Desafio01Relatorios.Parser

  # teste no iex com time
  # Desafio01Relatorios.build("report.txt")
  # iex(8)> :timer.tc(fn -> Desafio01Relatorios.build("report.txt") end)

  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp sum_values(
         [name, hour, _day, month, eyer],
         %{
           :all_hours => all_hours,
           :hours_per_month => hours_per_month,
           :hours_per_year => hours_per_year
         }
       ) do
    all_hours = merge_maps(all_hours, %{name => hour})

    hours_per_month = merge_sub(hours_per_month, %{name => %{month => hour}})

    hours_per_year = merge_sub(hours_per_year, %{name => %{eyer => hour}})

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_sub(map1, map2) do
    Map.merge(map1, map2, fn _k, v1, v2 ->
      merge_maps(v1, v2)
    end)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, v1, v2 -> v1 + v2 end)
  end

  defp report_acc() do
    build_report(%{}, %{}, %{})
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      :all_hours => all_hours,
      :hours_per_month => hours_per_month,
      :hours_per_year => hours_per_year
    }
  end
end
