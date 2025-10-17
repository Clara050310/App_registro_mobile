class Usuario {
  String id;
  String nome;
  String email;
  String? fotoUrl; // opcional
  String cargo;    // exemplo: "Motorista", "Operador"

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.fotoUrl,
    required this.cargo,
  });

  // Convertendo objeto para Map (Firebase)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'fotoUrl': fotoUrl,
      'cargo': cargo,
    };
  }

  // Criando objeto a partir de Map do Firebase
  factory Usuario.fromMap(String id, Map<String, dynamic> map) {
    return Usuario(
      id: id,
      nome: map['nome'],
      email: map['email'],
      fotoUrl: map['fotoUrl'],
      cargo: map['cargo'] ?? '',
    );
  }
}
