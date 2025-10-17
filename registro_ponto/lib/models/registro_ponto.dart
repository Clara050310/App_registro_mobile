class RegistroPonto {
  String id;
  String usuarioId;
  DateTime dataHora;
  String tipo; // "entrada" ou "saida"
  String? localizacao; // opcional, caso queira usar geolocalização

  RegistroPonto({
    required this.id,
    required this.usuarioId,
    required this.dataHora,
    required this.tipo,
    this.localizacao,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'dataHora': dataHora.toIso8601String(),
      'tipo': tipo,
      'localizacao': localizacao,
    };
  }

  factory RegistroPonto.fromMap(String id, Map<String, dynamic> map) {
    return RegistroPonto(
      id: id,
      usuarioId: map['usuarioId'],
      dataHora: DateTime.parse(map['dataHora']),
      tipo: map['tipo'],
      localizacao: map['localizacao'],
    );
  }
}
