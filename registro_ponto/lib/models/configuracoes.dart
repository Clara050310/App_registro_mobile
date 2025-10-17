class Configuracoes {
  bool notificacoesAtivas;
  String tema; // "claro" ou "escuro"

  Configuracoes({
    required this.notificacoesAtivas,
    required this.tema,
  });

  Map<String, dynamic> toMap() {
    return {
      'notificacoesAtivas': notificacoesAtivas,
      'tema': tema,
    };
  }

  factory Configuracoes.fromMap(Map<String, dynamic> map) {
    return Configuracoes(
      notificacoesAtivas: map['notificacoesAtivas'] ?? true,
      tema: map['tema'] ?? 'claro',
    );
  }
}
