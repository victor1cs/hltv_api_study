# HLTV API Study

API REST desenvolvida em Ruby on Rails para estudo e consulta de dados relacionados a times e jogadores de Counter-Strike, inspirada no HLTV.

## Sobre o Projeto

Esta é uma API RESTful que fornece endpoints para consultar informações sobre times de Counter-Strike, seus jogadores e países. O projeto foi desenvolvido como um estudo de caso utilizando Ruby on Rails 8.1.

**Este projeto está completamente dockerizado!** Não é necessário instalar Ruby, PostgreSQL ou qualquer outra dependência localmente. Tudo funciona através do Docker.

## Tecnologias Utilizadas

- **Ruby** 3.3.10
- **Rails** 8.1.2
- **PostgreSQL** 15 - Banco de dados
- **Docker** & **Docker Compose** - Containerização
- **Kaminari** - Paginação
- **Active Model Serializers** - Serialização de JSON
- **Puma** - Servidor web

## Pré-requisitos

A única dependência necessária é:

- **Docker** e **Docker Compose** instalados na sua máquina

## Instalação e Execução

**1.** Clone o repositório:
```bash
git clone git@github.com:victor1cs/hltv_api_study.git
cd hltv_api_study
```

**2.** Construa as imagens Docker:
```bash
docker-compose build
```

**3.** Configure o banco de dados (criar, migrar e popular):
```bash
docker-compose run web bash rails db:create db:migrate db:seed
```
**Obs:** O seed é populado com base no arquivo json `db/data/teams.json` 
Arquivo da internet disponibilizado pelo link: https://hltv-api.vercel.app/api/player.json

**4.** Inicie os serviços:
```bash
docker-compose up
```

## Endpoints:
Atualmente, a API disponibiliza informações sobre os times através da seguinte rota:

Exemplo:
```
GET /api/v1/teams
```

Resposta:
```
[
    {
        "id": 1,
        "name": "Vitality",
        "ranking": 1,
        "logo": "https://..."
    },
    {
        "id": 2,
        "name": "FaZe",
        "ranking": 2,
        "logo": "https://..."
    },
    {
        "id": 3,
        "name": "Liquid",
        "ranking": 3,
        "logo": "logo": "https://..."
    },
    {
        "id": 4,
        "name": "Natus Vincere",
        "ranking": 4,
        "logo": "logo": "https://..."
    },
    {
        "id": 5,
        "name": "G2",
        "ranking": 5,
        "logo": "logo": "https://..."
    }
]
```

Para evitar que todos os times sejam retornados de uma vez e limitar o consumo da API, foi configurada uma paginação utilizando **Kaminari**. Quando nenhum parâmetro é informado, a API retorna **no máximo 5 times**. Também é possível paginar os resultados, com um limite máximo de **10 times por página**.

Exemplo:
```
GET /api/v1/teams?page=1&per_page=2
```

Resultado:
```
[
    {
        "id": 1,
        "name": "Vitality",
        "ranking": 1,
        "logo": "https://..."
    },
    {
        "id": 2,
        "name": "FaZe",
        "ranking": 2,
        "logo": "https://..."
    }
]
```
**Explicação:**
page=1: **define a primeira página**
per_page=02: **define quantos resultados por página**
Se alguém tentar:
```
GET /api/v1/teams?page=1&per_page=50
```
A API ainda retornará **10**, pois é o limite definido.

É possível realizar busca por nome de time em especifico:
```
GET /api/v1/teams/:name
```
Exemplo:

```
GET /api/v1/teams/vitality
```

Resposta sucesso:
```
{
  "id": 1,
  "name": "Vitality",
  "ranking": 1,
  "logo": "https://..."
}
```

Resposta not found (404):
```
{
  "error": "Team not found"
}
```

Também é possível consultar a lista de Players com base no time pela rota:
```
GET /api/v1/teams/:name/players
```

Exemplo:
```
GET /api/v1/teams/vitality/players
```

Resposta:
```
[
    {
        "id": 1,
        "just_name": "Dan Madesclaire",
        "nickname": "apEX",
        "name": "Dan 'apEX' Madesclaire",
        "image": "https:...",
        "country": "France"
    },
    {
        "id": 2,
        "just_name": "Peter Rasmussen",
        "nickname": "dupreeh",
        "name": "Peter 'dupreeh' Rasmussen",
        "image": "https:...",
        "country": "Denmark"
    },
    {
        "id": 3,
        "just_name": "Emil Reif",
        "nickname": "Magisk",
        "name": "Emil 'Magisk' Reif",
        "image": "https:...",
        "country": "Denmark"
    },
    {
        "id": 4,
        "just_name": "Mathieu Herbaut",
        "nickname": "ZywOo",
        "name": "Mathieu 'ZywOo' Herbaut",
        "image": "https:...",
        "country": "France"
    },
    {
        "id": 5,
        "just_name": "Lotan Giladi",
        "nickname": "Spinx",
        "name": "Lotan 'Spinx' Giladi",
        "image": "https:...",
        "country": "Israel"
    }
]
```
