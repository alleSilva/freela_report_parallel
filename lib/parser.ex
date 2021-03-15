defmodule FreelaReport.Parser do
  @months %{
    "1" => :janeiro,
    "2" => :feveireiro,
    "3" => :março,
    "4" => :abril,
    "5" => :maio,
    "6" => :junho,
    "7" => :julho,
    "8" => :agosto,
    "9" => :setembro,
    "10" => :outubro,
    "11" => :novembro,
    "12" => :dezembro
  }

  def parse_file(file_name) do
    "reports/#{file_name}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    # [:name, hours_per_day, day, :month, year]
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &parse_name/1)
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(3, &parse_month/1)
    |> List.update_at(4, &String.to_integer/1)
  end

  defp parse_name(name) do
    name
    |> String.downcase()
    |> String.to_atom()
  end

  defp parse_month(month), do: @months[month]
end
