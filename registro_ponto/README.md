### APP REGISTRO DE PONTO

## Objetivo do projeto
- Desenvolver um aplicativo mobile em Flutter que permita o registro de ponto de funcionários, utilizando autenticação por NIF e senha ou biometria facial, além de validar por geolocalização para garantir que o registro ocorra dentro de um raio de 100 metros do local de trabalho

  ## Funcionalidade do porjeto
  # Autenticação de Uusário
  - Login com NIF e senha via Firebase
  -  Login alternativo via Reconhecimento Facial (biometria local).

  # Geolocalização
  - Uso do pacote geolocator para capturar latitude e longitude
  - Verificação automática se o usuário está dentro do raio permitido (100m)

  # Registro de ponto
  - Armazena data, hora e localização GPS no Firebase
  - Exibe historico de registro de ponto so usuário autenticado

  # Integração com FIrebase
  - Firebase Authentication
  - Firebase Firestore
  - Firebase Storage
 
  ## Tecnologias utilizadas
  - Flutter
  - Visual Studio Code
  - Firebase
  - local_auth
  - geolocator
  - Firestore
 
  ## Requisitos funcionais
  - O sistema deve permitir o login por NIF e senha.
  - O sistema deve permitir a autenticação via biometria facial.
  - O sistema deve capturar a localização atual (GPS) do usuário ao tentar registrar o ponto.
  - O sistema deve verificar se o usuário está a até 100 metros do local de trabalho antes de registrar o ponto.
  - O sistema deve registrar o ponto no Firebase Firestore, incluindo data, hora, NIF e localização (latitude e longitude).
  - O sistema deve exibir o histórico de registros de ponto do usuário autenticado.
  - O sistema deve exibir mensagens de erro quando o usuário estiver fora da área permitida ou ocorrer falha de autenticação.
  - O sistema deve permitir o logout do usuário.
 
  ## Requsiitos não funcioanis
  - O aplicativo deve ser desenvolvido em Flutter e compatível com Android e iOS.
  - O banco de dados deve utilizar o Firebase Firestore.
  - O sistema deve garantir a segurança dos dados do usuário por meio de autenticação Firebase.
  - O tempo de resposta para registro de ponto não deve ultrapassar 3 segundos.
  - O aplicativo deve seguir boas práticas de UI/UX, utilizando uma interface intuitiva e responsiva.
  - O código-fonte deve estar organizado seguindo o padrão MVC.
  - O aplicativo deve solicitar permissão explícita de acesso à localização e biometria.
 
  ## Casos de erro
  - Usuário insere NIF ou senha incorretos | AÇÃO DO SISTEMA: Impede o login e mantém o usuário na tela de autenticação.
  - Dispositivo sem permissão de localização | AÇÃO DO SISTEMA: Solicita a permissão via Geolocator.requestPermission().
  - Falha na conexão com o Firebase | AÇÃO DO SISTEMA: Exibe mensagem e tenta reconectar automaticamente.
  - Erro ao salvar registro no Firestore | AÇÃO DO SISTEMA: Reexecuta a operação e registra o erro localmente.
  - Erro na leitura da biometria | AÇÃO DO SISTEMA: Retorna à tela de autenticação.
 
  ## Diagrama de caso de uso

  ``` mermaid

    graph TD
    Usuario -->|Login NIF/Senha| FirebaseAuth
    Usuario -->|Login Biometria| Biometria
    Usuario -->|Registrar Ponto| Geolocalizacao
    Geolocalizacao -->|Dentro do raio permitido| Firestore
    Firestore -->|Salvar data/hora/local| Historico

  ```

  ## Diagrama de arquitetura do sistema

  ``` mermaid

  graph LR
    App[Flutter App] --> FirebaseAuth[Firebase Authentication]
    App --> Firestore[Firebase Firestore]
    App --> GeoAPI[Geolocator API]
    App --> BioAPI[Local Auth API]
    FirebaseAuth --> Firestore

  ```

  ## Fluxo de fucnionamento do aplicativo

  ``` mermaid

  flowchart TD
    A[Inicio] --> B[Tela de Login]
    B -->|NIF/Senha| C[Autenticacao Firebase]
    B -->|Biometria| D[Validacao Facial]
    C --> E[Verificacao de Localizacao]
    D --> E
    E -->|Dentro do raio| F[Registrar Ponto]
    E -->|Fora do raio| G[Erro: Fora do Local]
    F --> H[Salvar no Firestore]
    H --> I[Exibir Historico]
    I --> J[Fim]

  ```
  
  
