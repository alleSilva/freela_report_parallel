defmodule FreelaReportParallelTest do
  use ExUnit.Case

  describe("build/1") do
    test "builds the report" do
      file_name = "test_report.csv"

      response = FreelaReportParallel.build(file_name)

      expected_response = %{
        all_hours: %{
          cleiton: 12,
          daniele: 21,
          danilo: 7,
          diego: 12,
          giuliano: 14,
          jakeliny: 22,
          joseph: 13,
          mayk: 19,
          rafael: 7
        },
        hours_per_month: %{
          cleiton: %{junho: 4, outubro: 8},
          daniele: %{abril: 7, dezembro: 5, junho: 1, maio: 8},
          danilo: %{abril: 1, feveireiro: 6},
          diego: %{abril: 4, agosto: 4, dezembro: 1, setembro: 3},
          giuliano: %{abril: 1, feveireiro: 9, maio: 4},
          jakeliny: %{julho: 8, março: 14},
          joseph: %{dezembro: 2, março: 3, novembro: 5, setembro: 3},
          mayk: %{dezembro: 5, julho: 7, setembro: 7},
          rafael: %{julho: 7}
        },
        hours_per_year: %{
          cleiton: %{2016 => 3, 2020 => 9},
          daniele: %{2016 => 10, 2017 => 3, 2018 => 7, 2020 => 1},
          danilo: %{2018 => 1, 2019 => 6},
          diego: %{2016 => 3, 2017 => 8, 2019 => 1},
          giuliano: %{2017 => 3, 2019 => 6, 2020 => 5},
          jakeliny: %{2016 => 8, 2017 => 8, 2019 => 6},
          joseph: %{2017 => 3, 2019 => 3, 2020 => 7},
          mayk: %{2016 => 7, 2017 => 8, 2019 => 4},
          rafael: %{2017 => 7}
        }
      }

      assert response == expected_response
    end
  end

  describe("build_from_many/1") do
    test "builds the report from a list of file names, " do
      file_names = ["test_report.csv", "test_report.csv", "test_report.csv"]

      response = FreelaReportParallel.build_from_many(file_names)

      expected_response = {:ok,
      %{
        all_hours: %{
          cleiton: 36,
          daniele: 63,
          danilo: 21,
          diego: 36,
          giuliano: 42,
          jakeliny: 66,
          joseph: 39,
          mayk: 57,
          rafael: 21
        },
        hours_per_month: %{
          cleiton: %{junho: 12, outubro: 24},
          daniele: %{abril: 21, dezembro: 15, junho: 3, maio: 24},
          danilo: %{abril: 3, feveireiro: 18},
          diego: %{abril: 12, agosto: 12, dezembro: 3, setembro: 9},
          giuliano: %{abril: 3, feveireiro: 27, maio: 12},
          jakeliny: %{julho: 24, março: 42},
          joseph: %{dezembro: 6, março: 9, novembro: 15, setembro: 9},
          mayk: %{dezembro: 15, julho: 21, setembro: 21},
          rafael: %{julho: 21}
        },
        hours_per_year: %{
          cleiton: %{2016 => 9, 2020 => 27},
          daniele: %{2016 => 30, 2017 => 9, 2018 => 21, 2020 => 3},
          danilo: %{2018 => 3, 2019 => 18},
          diego: %{2016 => 9, 2017 => 24, 2019 => 3},
          giuliano: %{2017 => 9, 2019 => 18, 2020 => 15},
          jakeliny: %{2016 => 24, 2017 => 24, 2019 => 18},
          joseph: %{2017 => 9, 2019 => 9, 2020 => 21},
          mayk: %{2016 => 21, 2017 => 24, 2019 => 12},
          rafael: %{2017 => 21}
        }
      }}

      assert response == expected_response
    end

    test "returns an error if a list of file names is not passed as argument " do
      file_names = "test_report.csv"

      response = FreelaReportParallel.build_from_many(file_names)

      expected_response = {:error, "Argument must be a list of valid file names"}

      assert response == expected_response
    end
  end
end
