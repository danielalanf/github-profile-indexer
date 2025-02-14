# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

A versão utilizada para esse projeto é *ruby-3.2.2*

* Dependencias do sistema

**Ruby 3.2.2**
**Elasticsearch 7.17**
**Postgresql 16.16**

* Configuração

* Criação do banco de dados

* Database initialization

* Como rodar os testes

* Instale o Elasticsearch

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

* Baixar versão do ruby

Para baixar a versão do ruby usando o rvm

[rvm install](https://rvm.io/rvm/install)

* Alguns Patterns utilizados no projeto

**Service Object**

**Query Object**

**Decorator**

**Filter**

**Factory**
