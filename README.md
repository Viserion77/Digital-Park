# Projeto do Senai
# Parque Malwee

- Projeto parque Malwee
- Criar pagina web para configuração do app e gerenciamento
- Criar app para os usuarios
- Armazenar dados na amazon

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