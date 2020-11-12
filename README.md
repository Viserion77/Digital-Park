# Projeto do Senai
## DIgital Park

### Projeto para o Parque Malwee
- Criar pagina web para configuração do app e gerenciamento. [Readme](./web/README.md)
- Criar app para os usuários. [Readme](./app/README.md)
- Armazenar dados no FireBase, e possuir apis REST. [Readme](./services/README.md)

### Tecnologias utilizadas
#### Flutter ^1.22.3
#### Node.js ^v14.8.0

### Estrutura do projeto

Atualmente, o projeto está organizado da seguinte maneira:

    services/                 | alocara todos os api back-end
    app/                      | Raiz do front-end mobile da aplicação
      lib/                    |
        components/           | Possui widgets personalizados que são usados ​​por várias telas diferentes
        database/             | Possui as configurações do banco persistido no cliente
        models/               | Contém arquivos, cada um com uma classe personalizada de um objeto amplamente utilizado em todo o aplicativo
        screens/              | Contém muitas pastas diferentes, cada uma correspondendo a uma tela diferente do aplicativo
        services/             | Contém algumas APIs da web e código de interação nativo
        theme/                | Contém apenas um `style.dart` com o tema do aplicativo que é acessado no arquivo `main.dart`
    web/                      | Raiz do front-end web da aplicação
      src/                    |
        core/                 | Componentes e funcionalidades do core da aplicação
        components/           | Componentes padrão e customizados do front-end
        views/                | Principais paginas

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