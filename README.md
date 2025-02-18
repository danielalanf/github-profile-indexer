# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- [Github Profile Indexer](#github-profile-indexer)
  - [Requisitos do Projeto](#requisitos-do-projeto)
  - [Pré-Requisitos](#pré-requisitos)
  - [Baixar projeto](#baixar-projeto)
  - [Instalar versão do Ruby](#instalar-versão-do-ruby)
  - [Instalar versão do Elasticsearch](#instalar-versão-do-elasticsearch)
  - [Criar banco de dados](#criar-banco-de-dados)
  - [Rodar migrations](#rodar-migrations)
  - [Instalar gems](#instalar-gems)
  - [Rodar projeto](#rodar-projeto)
  - [Rodar testes](#rodar-testes)
- [Desenvolvimento](#desenvolvimento)
  - [Justificativas](#justificativas)
  - [Patterns utilizados](#patterns-utilizados)
- [Encurtador de URL](#encurtador-de-url)
- [Melhorias](#melhorias)
- [Imagens](#imagens)

### Github Profile Indexer

Esse projeto é um webscraper em Ruby on Rails que completa as informações de um perfil do GitHub a partir da URL do usuário.

Desenvolvido para um teste técnico da empresa Fretadão.

### Requisitos do Projeto


| Nome | Descrição |
|----------|:-------------|
| Cadastro de Perfis | Deve-se haver uma página para cadastrar um nome e o endereço da página de perfil do Github. |
| Webscrapper| Quando o cadastro de um novo membro for realizado, então através de um webscarpper deve-se recuperar e armazenar da pagina do Github as informações: <br> &nbsp;&nbsp; ** Nome de usuário do Github <br> &nbsp;&nbsp; * Número de Followers <br> &nbsp;&nbsp; * Número de Following <br> &nbsp;&nbsp; * Número de Stars <br> &nbsp;&nbsp; * Número de contribuições no último ano <br> &nbsp;&nbsp; * URL da imagem de perfil <br> &nbsp;&nbsp; * Email <br> &nbsp;&nbsp; * Localização |
|Encurtamento de URLs| Ao cadastrar um perfil, a URL do Github deverá ser armazenada de forma encurtada, por exemplo, https://bitly.com/. |
|Re-escanear| Após cadastrado, também deve ser possível escanear (de forma manual) o perfil do Github em busca de novas informações que possam ter sido adicionadas. |
| Interface de Usuário | Implementar o front-end da tela de busca e perfil <br> &nbsp;&nbsp; * A página principal do sistema deverá exibir um campo de busca. <br> &nbsp;&nbsp; * A busca poderá ser preenchida com qualquer informação do perfil (nome, usuário do Github, organização, localização, etc). <br> &nbsp;&nbsp; * Os resultados deverão ser uma lista de usuários contendo nome, URL encurtada do perfil do Github e botões para editar/visualizar o registro. <br> &nbsp;&nbsp; * A página de perfil deverá exibir todos os campos salvos. <br> &nbsp;&nbsp; * Deve-se exibir a imagem de perfil do usuário utilizando a URL salva do Github. <br> &nbsp;&nbsp; * Deve-se adicionar botões para re-escanear/editar/remover o registro. <br> &nbsp;&nbsp;&nbsp;&nbsp; - OBS: deve-se apenas editar o nome e URL, já que os outros dados serão extraídos com Webscrapper.

### Pré-Requisitos

* *Ruby 3.2.2*
* *Elasticsearch 7.17*
* *Postgresql 16.16*

### Baixar projeto

Executar comando

```git clone git@github.com:danielalanf/github-profile-indexer.git```

### Instalar versão do Ruby

Para baixar a versão do ruby usando o rvm

[rvm install](https://rvm.io/rvm/install)

### Instalar versão do Elasticsearch

Se você estiver usando o Ubuntu, pode instalá-lo assim:

**Certifique-se de ter o Java 11 ou superior, pois o Elasticsearch 7.x exige isso.**

Adicione a chave pública do Elasticsearch:

```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```

Adicione o repositório do Elasticsearch 7.17: Crie o arquivo do repositório:

```
sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.17/apt stable main" > /etc/apt/sources.list.d/elastic-7.17.list'
```

Atualize os pacotes:

```
sudo apt-get update
```

Instale o Elasticsearch 7.17:

```
sudo apt-get install elasticsearch=7.17.*
```

Após a instalação, inicie o Elasticsearch:

```
sudo systemctl start elasticsearch
```

E verifique se o serviço está funcionando:

```
curl -X GET "localhost:9200/"
```

Se tudo estiver correto, você verá uma resposta JSON do Elasticsearch.

```
{
  "name" : "daniel-alan",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "y0OwghU5SOGMOf0fkDTt-g",
  "version" : {
    "number" : "7.17.0",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "bee86328705acaa9a6daede7140defd4d9ec56bd",
    "build_date" : "2022-01-28T08:36:04.875279988Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

### Criar banco de dados

Executar o comando ```rake db:create```

### Rodar migrations

Executar o comando ```rake db:migrate```

### Instalar gems

Executar o comando ```bundle install```

### Rodar projeto

Executar o comando ```rails s```

* O projeto estará disponível na URL *localhost:3000*

### Rodar testes

* Para rodar todos os testes completo executar o comando ```rspec```
* Para rodar uma classe especifica executar o comando ```rspec spec/CAMINHO_ARQUIVO/arquivo.spec```

### Desenvolvimento

* O projeto é baseado principalmente na arquitetura MVC do Rails.
* A chamada para o webscrapper é feita utilizando um service para remover a lógica do model.
* Foi utilizado concern para tratar códigos relacionados ao searchkick.
* As queries estão separadas na pasta query onde é tratado a busca e parametrização do elastic search.
* O filtro para enviar os dados ao controller está separado na pasta filter, tentei deixar o controller mais enxuto possível.
* O código foi implementado com o uso das gems RSpec (para criação dos testes unitários) e VCR, para reutilizar os dados para api's externas.

### Justificativas

* **Postgres**

A escolha do PostgreSQL para o projeto se baseou em sua robustez, escalabilidade e compatibilidade com as necessidades do sistema, garantindo uma base sólida para o crescimento e evolução da aplicação.

* **Elasticsearch / searchkick**

Utilizei Elasticsearch com a gem Searchkick para melhorar a performance e a precisão das buscas no projeto. Diferente das consultas tradicionais em banco de dados, o Elasticsearch permite realizar buscas *full-text*, sugestões automáticas e filtros avançados de forma rápida e eficiente. Além disso, ele é altamente escalável e pode lidar com grandes volumes de dados sem comprometer o desempenho.

O Searchkick foi escolhido por facilitar a integração do Elasticsearch com o ActiveRecord, permitindo indexar os dados automaticamente e executar buscas de maneira intuitiva dentro do Rails. Com isso, conseguimos melhorar a experiência do usuário, tornando as pesquisas mais rápidas e relevantes.

* **Bootstrap**

Utilizei o Bootstrap no projeto para facilitar a estilização e garantir um design responsivo sem precisar escrever muito CSS manualmente. O framework oferece uma estrutura pronta com grid flexível, componentes reutilizáveis e classes utilitárias que agilizam o desenvolvimento. Além disso, ele garante compatibilidade entre diferentes navegadores e melhora a experiência do usuário em dispositivos móveis. Dessa forma, foi possível criar um layout bonito e organizado de forma rápida e eficiente.

* **Fontawesome**

Utilizei o FontAwesome no projeto para adicionar ícones de forma prática e estilizada, sem precisar criar ou importar imagens manualmente. Ele oferece uma grande variedade de ícones personalizáveis, facilitando a criação de uma interface mais intuitiva e visualmente agradável. Além disso, como os ícones são vetoriais, eles mantêm a qualidade em qualquer tamanho e carregam rapidamente, contribuindo para a performance do site.

* **Sweet Alert**

Utilizei o SweetAlert no projeto para exibir alertas mais bonitos e interativos, substituindo os pop-ups padrão do navegador. Ele permite personalizar cores, ícones e botões, melhorando a experiência do usuário. Além disso, é fácil de integrar e usar, tornando as notificações mais visuais e intuitivas.

### Patterns utilizados no projeto

* Service Object

* Query Object

* Concern

* Decorator

* Filter

* Factory

### Encurtador de URL

O encurtador de URL foi implementado dentro do projeto e consiste em

* Uma tabela chamada short_urls que possui duas colunas long_ul e slug

A estratégia foi pensada para atender

* A exibição correta na tela de edição do User
* Link gerado para as telas de exibição, que exibe a url encurtada e redireciona para o perfil correto do Github
* Não precisa de requisições externas
* Financeiramente viável pois não tem custo.

### Melhorias

* **Dockerizar:** o projeto para facilitar a gestão do ambiente de desenvolvimento, além de melhorar a escalabilidade e o gerenciamento das dependências do sistema, criando um fluxo de trabalho mais eficiente tanto para desenvolvimento quanto para deploy em produção.

* **Webscraper:** Durante o desenvolvimento do projeto, utilizamos a gem Nokogiri para extrair atributos do perfil do GitHub. Inicialmente, os testes passaram sem problemas, pois o perfil escolhido não possuía contribuições no último ano. No entanto, ao testar com um perfil que possuía contribuições maiores que zero, um erro ocorreu. Descobrimos que o atributo last_year_contributions é carregado de forma assíncrona, e o GitHub utiliza um *include-fragment* com um src dinâmico, impedindo a extração direta do conteúdo. Para solucionar esse problema, uma abordagem seria utilizar a gem **selenium-webdriver**, permitindo carregar o conteúdo dinamicamente antes da extração dos dados.

### Imagens

Tela principal
<img src="/public/telas/index.png">

Exibe um perfil
<img src="/public/telas/show.png">
