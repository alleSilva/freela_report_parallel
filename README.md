# Desafio 02 - Gerando relatórios com paralelismo

## Sobre o desafio

Nesse desafio, você deverá gerar o mesmo relatório com os mesmos dados do desafio anterior mas dessa vez os dados estão fracionados em três arquivos com 10 mil linhas cada e o relatório deve ser gerado usando esses três arquivos em paralelo.

Observe que o resultado final do cálculo de horas de cada pessoa para ano, mês e total de horas deve ser o mesmo do desafio anterior, já que os dados continuam iguais.

O relatório gerado a partir dos arquivos (que estão disponíveis para download logo abaixo) deve estar no seguinte formato:

```elixir
%{
  all_hours: %{
        danilo: 500,
        rafael: 854,
        ...
    },
  hours_per_month: %{
        danilo: %{
            janeiro: 40,
            fevereiro: 64,
            ...
        },
        rafael: %{
            janeiro: 52,
            fevereiro: 37,
            ...
        }
    },
  hours_per_year: %{
        danilo: %{
            2016: 276,
            2017: 412,
            ...
        },
        rafael: %{
            2016: 376,
            2017: 348,
            ...
        }
    }
}
```
Os caracteres ... é o espaço onde ficaria o resto dos dados. Esse é apenas um exemplo visual do que o retorno da função deve possuir, beleza?

Se quiser testar a sua implementação a partir do terminal, rode `iex -S mix` dentro do diretório raiz do projeto 🚀

## Testes

Para rodar o teste da função FreelaReport.Parser.parse_file/1 e da função FreelaReport.build/1, executar o comando no terminal:

`mix test`


