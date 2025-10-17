

import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return true;
    } catch (e) {
      print('Erro de login: $e');
      return false;
    }
  }

  Future<bool> register(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      return true;
    } catch (e) {
      print('Erro ao registrar: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<bool> loginBiometrico() async {
    return false; // TODO: Implement biometric login
  }
}
