import 'package:flutter/material.dart';
import 'package:registro_ponto/views/home_views.dart';
import '../controllers/auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Alterado para NIF (Número de Identificação Fiscal/CPF/Identificador)
  final TextEditingController nifController = TextEditingController(); 
  final TextEditingController senhaController = TextEditingController();
  
  // Novo estado para controlar o loading do botão
  bool _isLoading = false; 

  final AuthController _auth = AuthController();

  // Método para login com NIF e Senha
  Future<void> _loginNifSenha() async {
    if (nifController.text.isEmpty || senhaController.text.isEmpty) {
      _showSnackBar("Preencha NIF e Senha.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Nota: O AuthController precisa adaptar o NIF para o formato de login (ex: NIF@app.com)
      await _auth.login(
        nifController.text.trim(),
        senhaController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
      }
    } catch (e) {
      _showSnackBar("Falha no login. Verifique as credenciais.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Novo método para login Biométrico
  Future<void> _loginBiometrico() async {
    // 1. Mostrar um indicador que o app está esperando a biometria
    _showSnackBar("Aguardando autenticação biométrica...");

    try {
      // 2. Chamar a função de biometria do AuthController
      // (Você precisará de pacotes como local_auth e configuracao nativa)
      bool authenticated = await _auth.loginBiometrico();

      if (authenticated) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeView()),
          );
        }
      } else {
        _showSnackBar("Falha ou cancelamento da autenticação biométrica.");
      }
    } catch (e) {
      _showSnackBar("Biometria não disponível ou erro: $e");
    }
  }

  // Função auxiliar para mostrar SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4F7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título e Introdução
                const Text(
                  "Bem-vindo ao Registro Ponto",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF69B4),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Campo NIF (ajustado para teclado numérico)
                TextField(
                  controller: nifController,
                  keyboardType: TextInputType.number, // Requisito NIF/numérico
                  decoration: InputDecoration(
                    labelText: "NIF ou Identificador",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Campo Senha
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Botão de Login (NIF/Senha)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _loginNifSenha,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFFFF69B4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Entrar",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Botão de Biometria (Adicionado)
                const Text("OU", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),

                IconButton(
                  onPressed: _isLoading ? null : _loginBiometrico,
                  icon: const Icon(
                    Icons.fingerprint, // Ícone para biometria (impressão digital ou facial)
                    size: 50,
                    color: Color(0xFFFF69B4),
                  ),
                  tooltip: 'Login com Biometria/Facial',
                ),

                const SizedBox(height: 20),
                
                // Botão Criar Conta
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterView()),
                          );
                        },
                  child: const Text(
                    "Criar conta",
                    style: TextStyle(color: Color(0xFFFF69B4)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}