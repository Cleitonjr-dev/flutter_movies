# MovierApp

Aplicativo Flutter para descoberta de filmes e series — busca, detalhes com elenco e episodios, e programacao diaria da TV por pais. Consome a [API TVMaze](https://www.tvmaze.com/api).

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.44.4-7C3AED?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.12.2-8B5CF6?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/Material_Design_3-purple?logo=material-design" alt="Material 3">
  <img src="https://img.shields.io/badge/build-passing-brightgreen" alt="Build">
  <img src="https://img.shields.io/badge/tests-2%2F2_passed-brightgreen" alt="Tests">
  <img src="https://img.shields.io/badge/analysis-0_errors-brightgreen" alt="Analysis">
</p>

<p align="center">
  <sub>Light</sub>
  &nbsp;&nbsp;·&nbsp;&nbsp;
  Roxo <code>#7C3AED</code>
  &nbsp;|&nbsp;
  Magenta <code>#D946EF</code>
  &nbsp;|&nbsp;
  Coral <code>#FF6B5F</code>
  <br>
  <sub>Dark</sub>
  &nbsp;&nbsp;·&nbsp;&nbsp;
  Lilas <code>#8B5CF6</code>
  &nbsp;|&nbsp;
  Rosa <code>#E056FD</code>
  &nbsp;|&nbsp;
  Laranja <code>#FF7A59</code>
</p>

---

## Funcionalidades

### Listagem
- Busca por nome com `TextField` na AppBar
- Cards com poster, nome e generos (ate 3)
- Tratamento de estados: **loading**, **erro** (com tentar novamente) e **vazio**

### Detalhes (3 abas)
| Aba | Conteudo |
|-----|----------|
| **Info** | Poster, nota (estrela), status (Finalizada/Em exibicao), chips de generos, sinopse, estreia, emissora, idioma, duracao e site oficial clicavel |
| **Elenco** | Lista com foto do ator e nome do personagem |
| **Episodios** | Agrupados por temporada em `ExpansionTile`, com numero e data de exibicao |

### Programacao de Hoje
- Grade do que esta passando na TV hoje
- Seletor de pais com 12 opcoes (US, GB, BR, CA, AU, JP, DE, FR, IT, ES, PT, MX)
- Nome da serie, episodio, temporada, horario

### Tema
- Modo **claro** e **escuro** com toggle de um toque
- Gradiente no AppBar (roxo → lilas → magenta → coral)
- Paleta premium estilo IMDb / Letterboxd
- Material Design 3 completo

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

**Clean Architecture simplificada** com Repository Pattern:

```
lib/
├── main.dart                               # Entry point
├── app.dart                                # MaterialApp + tema
├── core/
│   ├── constants/
│   │   └── api_constants.dart              # URLs da API
│   └── theme/
│       └── app_theme.dart                  # AppColors + ThemeData (light/dark)
├── models/
│   ├── movie.dart                          # Movie (imutavel, fromJson null-safe)
│   ├── cast_member.dart                    # CastMember (ator + personagem)
│   └── episode.dart                        # Episode (temporada, data, resumo)
├── repositories/
│   └── movie_repository.dart              # Repository injetavel + ScheduleEpisode
└── screens/
    ├── movies/
    │   └── movies_screen.dart              # Listagem + busca funcional
    ├── detail/
    │   ├── detail_screen.dart              # Tela de detalhes com TabBar
    │   └── widgets/
    │       ├── info_tab.dart              # Aba de informacoes
    │       ├── cast_tab.dart              # Aba de elenco
    │       └── episodes_tab.dart          # Aba de episodios
    └── schedule/
        └── schedule_screen.dart           # Programacao de hoje
```

### Camadas

| Camada | Responsabilidade |
|--------|-----------------|
| **Screens** | UI — renderizacao e interacao com usuario |
| **Repositories** | Dados — comunicacao com API, injetavel via `http.Client` |
| **Models** | Dominio — entidades imutaveis com serializacao null-safe |
| **Core** | Infra — constantes, cores e tema compartilhado |

---

## Como funciona

### Busca e Listagem
1. Ao abrir, busca padrao por "star trek" via `MovieRepository.fetchMovies()`
2. JSON decodificado e mapeado para `List<Movie>` com null-safety e fallback para imagem
3. Loading → `CircularProgressIndicator` / Erro → mensagem + botao / Vazio → texto

### Detalhes
1. Toque no card → `DetailScreen` com `DefaultTabController` de 3 abas
2. **Info**: dados direto do modelo `Movie` (ja vindos da busca)
3. **Elenco**: `GET /shows/:id/cast` → `CastTab`
4. **Episodios**: `GET /shows/:id/episodes` → `EpisodesTab` agrupado por temporada

### Programacao
1. Icone de relogio na AppBar → `ScheduleScreen`
2. `GET /schedule?country=:code` → lista de `ScheduleEpisode`
3. Dropdown troca de pais → nova requisicao

### Tema
- `ValueNotifier<ThemeMode>` reativo com `ValueListenableBuilder` no `MaterialApp`
- Toggle via extensao `themeNotifier.toggle()` em todas as AppBars

---

## API TVMaze

Endpoints consumidos:

| Endpoint | Uso |
|----------|-----|
| `GET /search/shows?q={query}` | Busca de series |
| `GET /shows/:id/cast` | Elenco |
| `GET /shows/:id/episodes` | Episodios |
| `GET /schedule?country={code}` | Programacao diaria |

---

## Pre-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.44.4+
- Android Studio / Xcode (para builds mobile)
- Dispositivo ou emulador Android/iOS

---

## Instalacao e execucao

```bash
git clone <url-do-repositorio>
cd movier_app

flutter pub get
flutter run
```

### Comandos uteis

```bash
flutter test          # Testes de widget
flutter analyze       # Qualidade do codigo
flutter build apk --debug   # APK Android
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

Projeto de estudo. Livre para uso como referencia.
