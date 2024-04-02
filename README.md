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
2.Após a clonagem do repositório, abra o SQL Server Management e navegue até o diretório: 'projeto_dw/03.Scripts_Banco/01.DDL'
```

```
3.Execute em ordem os scripts:
- criacao_banco.sql >> operacional.sql >> dimensional.sql >> staging.sql
```

```
4.Navegue até o diretório: 'projeto_dw/03.Scripts_Banco/02.Povoamento_Operacional'
  Nesse diretório, os arquivos json não podem ser excluídos. Eles são os arquivos onde os dados estão guardados, prontos para serem carregados.
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
8.Os dados são de um banco de dados externo, então é necessário fazer o tratamento. Execute o script ETL.sql localizado no diretório 'projeto_dw/03.Scripts_Banco/05.Procedimentos_DW/ETL.sql'.
```

```
8.Os dados são de um banco de dados externo, então é necessário fazer o tratamento. Execute o script ETL.sql localizado no diretório 'projeto_dw/03.Scripts_Banco/05.Procedimentos_DW/ETL.sql'.
```

Termine com um exemplo de como obter dados do sistema ou como usá-los para uma pequena demonstração.

## ⚙️ Executando os testes

Explicar como executar os testes automatizados para este sistema.

### 🔩 Analise os testes de ponta a ponta

Explique que eles verificam esses testes e porquê.

```
Dar exemplos
```

### ⌨️ E testes de estilo de codificação

Explique que eles verificam esses testes e porquê.

```
Dar exemplos
```

## 📦 Implantação

Adicione notas adicionais sobre como implantar isso em um sistema ativo

## 🛠️ Construído com

Mencione as ferramentas que você usou para criar seu projeto

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - O framework web usado
* [Maven](https://maven.apache.org/) - Gerente de Dependência
* [ROME](https://rometools.github.io/rome/) - Usada para gerar RSS

## 🖇️ Colaborando

Por favor, leia o [COLABORACAO.md](https://gist.github.com/usuario/linkParaInfoSobreContribuicoes) para obter detalhes sobre o nosso código de conduta e o processo para nos enviar pedidos de solicitação.

## 📌 Versão

Nós usamos [SemVer](http://semver.org/) para controle de versão. Para as versões disponíveis, observe as [tags neste repositório](https://github.com/suas/tags/do/projeto). 

## ✒️ Autores

Mencione todos aqueles que ajudaram a levantar o projeto desde o seu início

* **Um desenvolvedor** - *Trabalho Inicial* - [umdesenvolvedor](https://github.com/linkParaPerfil)
* **Fulano De Tal** - *Documentação* - [fulanodetal](https://github.com/linkParaPerfil)

Você também pode ver a lista de todos os [colaboradores](https://github.com/usuario/projeto/colaboradores) que participaram deste projeto.

## 📄 Licença

Este projeto está sob a licença (sua licença) - veja o arquivo [LICENSE.md](https://github.com/usuario/projeto/licenca) para detalhes.

## 🎁 Expressões de gratidão

* Conte a outras pessoas sobre este projeto 📢;
* Convide alguém da equipe para uma cerveja 🍺;
* Um agradecimento publicamente 🫂;
* etc.


---
⌨️ com ❤️ por [Armstrong Lohãns](https://gist.github.com/lohhans) 😊
