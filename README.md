# Travel Wallet

Aplicativo Flutter para planejar viagens e controlar os gastos de cada uma delas. O usuário cria uma viagem com nome, orçamento e período, e depois registra as despesas por categoria acompanhando o quanto já foi consumido do orçamento.

Todos os dados ficam no próprio dispositivo (SQLite + SharedPreferences) — não há backend.

## Funcionalidades

- **Onboarding**: exibido apenas no primeiro acesso; a partir daí o app abre direto na home.
- **Planejamento de viagem**: formulário de criação/edição com nome, orçamento e datas de início e fim, com validação.
- **Home**: lista das viagens cadastradas, com estado vazio quando não há nenhuma.
- **Detalhes da viagem**: registro de despesas (descrição, valor, categoria e data), filtro por categoria e barra de progresso do orçamento.
- **Viagem encerrada**: depois do último dia da viagem, ela é marcada como finalizada e não aceita novas despesas.
- **Telas de autenticação** (sign in, sign up e recuperação de senha): apenas interface e validação de formulário, sem integração com um provedor de autenticação.
- **Internacionalização**: inglês e português (`lib/l10n`).

## Requisitos

- Flutter com Dart SDK `^3.12.2`
- Xcode (iOS) e/ou Android SDK

## Como rodar

```bash
flutter pub get
```

```bash
flutter run
```

Os arquivos de localização são gerados automaticamente pelo `flutter pub get` / `flutter run` (`generate: true` no `pubspec.yaml`, configurado em `l10n.yaml`).

## Testes

```bash
flutter test
```

Os testes de repositório usam `sqflite_common_ffi` com banco em memória (`test/helpers/in_memory_database.dart`), e os testes de controller usam `mocktail`.

## Estrutura

```
lib/
├── main.dart                  # bootstrap: DI + runApp
├── app/
│   ├── travel_wallet_app.dart # MaterialApp.router, tema e localizações
│   ├── di/                    # registro de dependências (get_it)
│   ├── routers/               # rotas e transições (go_router)
│   ├── themes/                # tema do app
│   ├── core/
│   │   ├── database/          # AppDatabase, CRUD helper e migrations
│   │   ├── storage/           # SharedPreferences por trás de ILocalStorage
│   │   ├── result/            # Result/Success/Failure
│   │   ├── constants/         # cores e imagens
│   │   ├── extends/           # extensions de navegação e tamanhos
│   │   └── widgtes/           # widgets compartilhados
│   └── features/
│       ├── onboarding/
│       ├── auth/
│       ├── home/
│       ├── traveler_planner/  # formulário de criação da viagem
│       └── travel_details/    # despesas e orçamento
└── l10n/                      # arquivos .arb e classes geradas
```

Cada feature segue a divisão `data/` (models, repositories, erros), `state/` (controller + estados) e `presentation/` / `widgets/`.

## Arquitetura

- **Estado**: `ChangeNotifier`/`ValueNotifier` por feature, com um estado por classe (`*_initial`, `*_loading`, `*_loaded`, `*_error`) implementando uma interface comum. As telas reagem ao controller registrado no `get_it`.
- **Injeção de dependência**: `get_it`, configurado em [di.dart](lib/app/di/di.dart).
- **Navegação**: `go_router`, com transição de fade + slide compartilhada em [app_router.dart](lib/app/routers/app_router.dart).
- **Erros**: repositórios e controllers retornam `Result` (`Success` / `Failure`) em vez de lançar exceções.

## Persistência

Banco SQLite `travel_wallet.db` (versão 2), definido em [app_database.dart](lib/app/core/database/app_database.dart):

- `travel_forms` — viagens (id, nome, orçamento, data inicial e final).
- `travel_expenses` — despesas, com `travel_id` referenciando `travel_forms` em `ON DELETE CASCADE` (`PRAGMA foreign_keys = ON` é habilitado na abertura) e índice por `travel_id`.

O flag de primeiro acesso do onboarding fica no `SharedPreferences`, acessado através de `ILocalStorage`.
