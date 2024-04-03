# Football Manager - Scouting

Esse é um projeto desenvolvido para a disciplina de Sistemas de Apoio à Decisão. Seu objetivo é construir um ambiente dimensional de um Datawarehouse para gerar relatórios sobre o banco de dados de jogadores. A ideia é facilitar esses relatórios, que podem servir como apoio ao negócio, se analisados por um scouter.

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.

Consulte **[Implantação](#-implanta%C3%A7%C3%A3o)** para saber como implantar o projeto.

### 📋 Pré-requisitos

Para usufruir do sistema, é necessário apenas ter o SQL Server instalado e uma ferramenta de consulta, como por exemplo o SQL Server Management.


### 🔧 Instalação

Para que tudo ocorra bem, basta seguir os seguintes passos:

```
1.Clonar o repositório em máquina local ou baixar o arquivo zip do mesmo.
  git clone https://github.com/paulovsnts/Scouting_Football_Manage
```

```
2.Após a clonagem do repositório, abra o SQL Server Management e navegue até o diretório:
  'projeto_dw/03.Scripts_Banco/01.DDL'
```

```
3.Execute em ordem os scripts:
  criacao_banco.sql >> operacional.sql >> dimensional.sql >> staging.sql
```

```
4.Navegue até o diretório: 'projeto_dw/03.Scripts_Banco/02.Povoamento_Operacional'
  Nesse diretório, os arquivos json não podem ser excluídos.
  Eles são os arquivos onde os dados estão guardados, prontos para serem carregados.
```

```
5.Execute os scripts de povoamento, na ordem de: ligas >> times >> jogadores >> transferencias.
```

```
6.Navegue até a próxima subpasta e execute o script de povoamento da dimensão tempo.
```

```
7.Continue navegando para a próxima hierarquia de pastas e execute os scripts dos povoamentos OLTP.
  Siga a mesma sequência: ligas >> times >> jogadores >> transferências.
  Após isso, a área de staging estará devidamente preenchida.
```

```
8.Os dados são de um banco de dados externo, então é necessário fazer o tratamento.
  Execute o script ETL.sql localizado no diretório 'projeto_dw/03.Scripts_Banco/05.Procedimentos_DW/ETL.sql'.
```

```
9.Há um script solto: violacoes.sql'.
  Ele deve ser executado para garantir que os dados na tabela de fato sejam válidos, e caso haja violação, não será inserido, mas irá ser registrado na tabela de violações.
```

```
10.Após executar o ETL e criar a tabela de violação, os dados das tabelas auxiliares da área de staging estarão tratadas.
   Dessa forma, o próximo passo é povoar o ambiente dimensional. Faça isso navegando no diretório 'projeto_dw/03.Scripts_Banco/05.Procedimentos_DW'.
   Execute os scripts na ordem: sp_dim_liga.sql >> sp_dim_time.sql >> sp_dim_jogador.sql >> sp_fato_contratacao. 
```

```
10.Finalmente, após tudo isso, é possível criar o agregado, com granularidade de total gasto em contratações por time no ano.
   O script é o agregados.sql.
```

```
11.Por último, é possível realizar as verificações de alguns indicadores propostos pelo estudo de caso (este presente no diretório 'projeto_dw/01.Estudo_Caso'.
   Basta executar o script 'projeto_dw/03.Scripts_Banco/06.Verificacao/verificacao.sql'.
```

Para um bom aproveitamento e entendimento do projeto, não esqueça de ler o estudo de caso (disponível em word e pdf) e ver o projeto do banco, disponibilizado em imagens.

## ⚙️ Executando os testes

Você pode testar o datawarehouse por meio de consultas sql, fazendo verificações que atendam a indicadores (do estudo de caso ou propostos por você mesmo). 

## 📦 Implantação

Para o projeto da disciplina, essa base de dados é usada para gerar relatórios que atendam aos indicadores do estudo de caso. Assim, o modo mais prático de implantar esse datawarehouse em algo real é usando ferramentas de BI (Business Inteligence). No caso do repositório, disponibilizo meu relatório feito no Power BI.

[Link]

## 🛠️ Construído com

* [SQL Server Management Studio](https://learn.microsoft.com/pt-br/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) - Ferramenta usadas para desenvolver os scripts e realizar as consultas 
* [Power BI](https://powerbi.microsoft.com/pt-br/desktop/) - Ferramenta de BI para relatórios
* [Transfermarkt API](https://github.com/felipeall/transfermarkt-api) - API usada para retirar os dados 

## ✒️ Autores

* **Paulo Vítor dos Santos** - *Desenvolvedor* - [Paulo](https://github.com/paulovsnts)
* **Natan Vinícius Santos Pereira** - *Desenvolvedor* - [Natan](https://github.com/NatanVini7)
* **André Vinicius Rodrigues Passos Nascimento** - *Orientador* - [André](https://github.com/andreviniciusnascimento)

## 📄 Licença

Este projeto está sob a licença MIT - veja o arquivo [LICENSE.md](https://github.com/paulovsnts/Scouting_Football_Manager/blob/main/LICENSE) para detalhes.

## 🎁 Expressões de gratidão

* Esse é o meu primeiro projeto na área de Banco de Dados. Agradeço à equipe que colaborou para que ele fosse desenvolvido 📢;
* Aos interessados na área e no projeto, podem (e devem) comentar, sugerir e contribuir com o projeto. Mande um email para paulovsnts47@gmail.com 🍺;
* Minhas áreas de interesse são banco de dados, business inteligence, inteligência artificial, machine learning e ciência de dados. Estou ansioso por aprender cada vez mais sobre essas áreas, e desenvolver novos projetos 🫂;
