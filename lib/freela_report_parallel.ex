defmodule FreelaReportParallel do
  alias FreelaReportParallel.Parser

  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
        sum_values(line, report)
     end)
  end

  def build_from_many(file_names) when not is_list(file_names) do
    {:error, "Argument must be a list of valid file names"}
  end

  def build_from_many(file_names) do
    result =
      file_names
      |> Task.async_stream(&build/1)
      |> Enum.reduce(report_acc(), fn {:ok, result}, report ->
        sum_reports(result, report)
      end)

    {:ok, result}
  end

  defp sum_reports(
    %{
      :all_hours => all_hours_1,
      :hours_per_month => hours_per_month_1,
      :hours_per_year => hours_per_year_1
    },
    %{
      :all_hours => all_hours_2,
      :hours_per_month => hours_per_month_2,
      :hours_per_year => hours_per_year_2
    }) do
      all_hours = merge_maps(all_hours_1, all_hours_2)
      hours_per_month = merge_sub_maps(hours_per_month_1, hours_per_month_2)
      hours_per_year = merge_sub_maps(hours_per_year_1, hours_per_year_2)

      build_map(all_hours, hours_per_month, hours_per_year)
    end

  def sum_values([name, hours, _day, month, year],
    %{
      :all_hours => all_hours,
      :hours_per_month => hours_per_month,
      :hours_per_year => hours_per_year
    }) do
      all_hours = merge_maps(all_hours, %{name => hours})
      hours_per_month = merge_sub_maps(hours_per_month, %{name => %{month => hours}})
      hours_per_year = merge_sub_maps(hours_per_year, %{name => %{year => hours}})

      build_map(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp merge_sub_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 ->
      merge_maps(value1, value2) end)
  end

  defp build_map(all_hours, hours_per_month, hours_per_year) do
    %{
      :all_hours => all_hours,
      :hours_per_month => hours_per_month,
      :hours_per_year => hours_per_year
    }
  end

  defp report_acc(), do: build_map(%{}, %{}, %{})

end
