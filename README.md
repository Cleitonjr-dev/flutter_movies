# Flutter Movies

Aplicativo Flutter para busca e listagem de filmes e séries consumindo a [API TVMaze](https://www.tvmaze.com/api).

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.44.4-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/Material_Design-3-795548?logo=material-design" alt="Material 3">
  <img src="https://img.shields.io/badge/build-passing-brightgreen" alt="Build">
  <img src="https://img.shields.io/badge/tests-2%2F2%20passed-brightgreen" alt="Tests">
  <img src="https://img.shields.io/badge/analysis-0%20issues-brightgreen" alt="Analysis">
</p>

---

## Funcionalidades

- Listagem de filmes e séries da API TVMaze
- Busca por nome
- Tela de detalhes com imagem e link clicavel para pagina oficial
- Suporte a **Light Mode** e **Dark Mode** (Material Design 3)
- Tratamento de estados: **loading**, **erro** (com botao tentar novamente) e **lista vazia**
- Imagens com fallback para erros de carregamento
- Responsivo (SingleChildScrollView em telas menores)

---

## Stack

| Categoria | Tecnologia |
|-----------|------------|
| Framework | Flutter 3.44.4 |
| Linguagem | Dart 3.12.2 |
| UI | Material Design 3 |
| HTTP | `http` ^1.2.0 |
| Links | `url_launcher` ^6.3.0 / `flutter_linkify` ^6.0.0 |
| Lint | `flutter_lints` ^5.0.0 |
| Build Android | AGP 9.0.1 / Gradle 9.1 / Kotlin 2.3.20 / Java 17 |
| Build iOS | Minimum deployment target 12.0 |

---

## Arquitetura

O projeto segue uma **Clean Architecture simplificada** com Repository Pattern:

```
lib/
├── main.dart                          # Entry point
├── app.dart                           # MaterialApp + tema
├── core/
│   ├── constants/
│   │   └── api_constants.dart         # URL base da API
│   └── theme/
│       └── app_theme.dart             # ThemeData light/dark (Material 3)
├── models/
│   └── movie.dart                     # Modelo imutavel com fromJson seguro
├── repositories/
│   └── movie_repository.dart          # Repository injetavel com http.Client
└── screens/
    ├── movies/
    │   └── movies_screen.dart         # Listagem + busca funcional
    └── detail/
        └── detail_screen.dart         # Detalhes + Linkify corrigido
```

### Camadas

| Camada | Responsabilidade |
|--------|-----------------|
| **Screens** | UI — renderizacao e interacao com usuario |
| **Repositories** | Dados — comunicacao com API, injetavel e testavel |
| **Models** | Dominio — entidades imutaveis com serializacao null-safe |
| **Core** | Infra — constantes, temas e configuracao compartilhada |

---

## Como funciona

### Fluxo principal

1. Ao abrir o app, `MoviesScreen.initState()` dispara uma busca padrao por "star trek"
2. A requisicao e feita pelo `MovieRepository` usando o pacote `http`
3. A resposta JSON e decodificada e mapeada para `List<Movie>`
4. Enquanto carrega, um `CircularProgressIndicator` e exibido
5. Se houver erro, aparece a mensagem com botao "Tentar novamente"
6. Se a lista vier vazia, aparece "Nenhum filme encontrado"

### Busca

- O icone de lupa na AppBar alterna para um `TextField`
- Ao submeter (Enter), a busca e realizada na API
- O icone X fecha o campo e restaura o titulo

### Detalhes

- Ao tocar em um filme, navega para `DetailScreen`
- Exibe a imagem do poster (com fallback se falhar)
- Exibe o link oficial como texto clicavel via `Linkify`
- Ao tocar no link, abre no navegador externo (`url_launcher`)
- Se nao for possivel abrir, exibe um `SnackBar`

---

## Pre-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.44.4 ou superior
- Android Studio / Xcode (para builds mobile)
- Dispositivo ou emulador Android/iOS

---

## Instalacao e execucao

```bash
# Clone o repositorio
git clone <url-do-repositorio>
cd flutter_movies

# Instale as dependencias
flutter pub get

# Execute o app
flutter run
```

### Executar testes

```bash
flutter test
```

### Verificar qualidade do codigo

```bash
flutter analyze
```

### Build Android (APK)

```bash
flutter build apk --debug
```

---

## API

O app consome a API publica do [TVMaze](https://www.tvmaze.com/api):

| Endpoint | Descricao |
|----------|-----------|
| `GET /search/shows?q={query}` | Busca series por nome |

Exemplo de resposta:

```json
[
  {
    "show": {
      "id": 123,
      "name": "Star Trek",
      "url": "https://www.tvmaze.com/shows/123/star-trek",
      "image": {
        "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"
      }
    }
  }
]
```

---

## Dependencias

| Pacote | Versao | Uso |
|--------|--------|-----|
| `http` | ^1.2.0 | Requisicoes HTTP |
| `url_launcher` | ^6.3.0 | Abertura de URLs externas |
| `flutter_linkify` | ^6.0.0 | Transforma texto em links clicaveis |
| `flutter_lints` | ^5.0.0 | Regras de lint (dev) |
| `flutter_test` | SDK | Testes de widget (dev) |

---

## Licenca

Este projeto e um aplicativo de estudo. Sinta-se livre para usar como referencia.
