# Projeto do Senai
## DIgital Park

### Projeto para o Parque Malwee
- Criar pagina web para configuração do app e gerenciamento. [Projeto](https://github.com/Hu3diger/digital-park-web)
- Criar app para os usuários. [Readme](./app/README.md)
- Armazenar dados no FireBase, e possuir apis REST. [Projeto](https://github.com/Hu3diger/digital-park-api)

### Tecnologias utilizadas
#### Flutter ^1.22.3
#### Node.js ^v14.8.0
#### Angular ^11.0.2

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/Viserion77/Digital-Park)

### Estrutura do projeto

Atualmente, o projeto está organizado da seguinte maneira:

    lib/                    |
      components/           | Possui widgets personalizados que são usados ​​por várias telas diferentes
      database/             | Possui as configurações do banco persistido no cliente
      models/               | Contém arquivos, cada um com uma classe personalizada de um objeto amplamente utilizado em todo o aplicativo
      screens/              | Contém muitas pastas diferentes, cada uma correspondendo a uma tela diferente do aplicativo
      services/             | Contém algumas APIs da web e código de interação nativo
      theme/                | Contém apenas um `style.dart` com o tema do aplicativo que é acessado no arquivo `main.dart`

### Nomenclatura das branches
Todas as branches criadas no GitHub devem seguir um padrão de nomenclatura e devem possuir apenas um propósito principal.

Exemplo:

`type/subject`
Tipos disponíveis:

- build
- ci
- docs
- feat
- feature
- fix
- hotfix
- integration
- perf
- refactor
- st
- style

### Commits
Metodologia padrão para realizar o commit dos arquivos, ela se chama conventional commits, abaixo, segue exemplo de utilização do padrão aplicado às mensagens de commit:

`type(scope): subject`
Tipos disponíveis:

- build: alterações que afetam o mecanismo de build ou dependências externas
- chore: pequenas tarefas, ajustes de estrutura, remoção de arquivos
- ci: alterações relacionadas à integração contínua do projeto
- docs: alterações (ou criações) às documentações do projeto
- feat: novas features
- fix: fixes de bugs e falhas
- improvement: pequenas melhorias realizadas aos códigos fonte do projeto
- perf: melhorias de performance aos códigos fonte
- refactor: refatorações de código
- revert: tratam de reverts de commits passados
- style: alterações de estilo de código (ESLint, geralmente)
- test: alterações relacionadas à testes unitários
