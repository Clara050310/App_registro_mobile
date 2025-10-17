import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; 
import '../controllers/auth_controller.dart'; 
import 'login_view.dart';
// REMOVIDO: NENHUMA REFERÊNCIA AO map_view.dart AQUI

class HomeView extends StatelessWidget {
 const HomeView({super.key});

 final Color primaryColor = const Color(0xFFFF69B4);

 // --- LÓGICA DE REGISTRO DE PONTO ---
 Future<void> _registrarPonto(BuildContext context) async {
try {
 // 1. Verificar Permissão
 LocationPermission permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
 permission = await Geolocator.requestPermission();
if (permission == LocationPermission.denied ||
permission == LocationPermission.deniedForever) {
 _showSnackBar(context, "Permissão de localização negada.");
return;
 }
 }

// 2. Obter Localização Atual
Position position = await Geolocator.getCurrentPosition(
 desiredAccuracy: LocationAccuracy.high);

 // 3. Obter Horário
String horario = DateTime.now().toString();

 // 4. Mostrar Confirmação
_showSnackBar(
context,
 "Ponto registrado com sucesso! \nHorário: ${horario.substring(11, 19)} \nLat/Lng: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}",
 isSuccess: true,
 );
 } catch (e) {
 _showSnackBar(context, "Erro ao registrar ponto: $e");
 }
 }

 void _showSnackBar(BuildContext context, String message, {bool isSuccess = false}) {
 ScaffoldMessenger.of(context).showSnackBar(
 SnackBar(
 content: Text(message),
 backgroundColor: isSuccess ? Colors.green : Colors.red,
 duration: const Duration(seconds: 4),
),
 );
 }

 @override
 Widget build(BuildContext context) {
return Scaffold(
 backgroundColor: const Color(0xFFFFF4F7),
 appBar: AppBar(
 title: const Text("Painel de Ponto"),
backgroundColor: primaryColor,
foregroundColor: Colors.white,
 actions: [
 IconButton(
 icon: const Icon(Icons.logout),
 onPressed: () async {
await AuthController().logout();
if (context.mounted) {
 Navigator.pushReplacement(
 context,
 MaterialPageRoute(builder: (_) => const LoginView()),
 );
 }
},
 )
 ],
 ),
 body: Center(
 child: Padding(
padding: const EdgeInsets.all(32.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
 const Text(
 "Bem-vindo ao seu painel de ponto 💼",
 style: TextStyle(
 fontSize: 22,
 fontWeight: FontWeight.bold,
 color: Color(0xFFFF69B4),
 ),
textAlign: TextAlign.center,
 ),
 const SizedBox(height: 80),

 // BOTÃO 1: Registrar Ponto
 SizedBox(
width: double.infinity,
 child: ElevatedButton.icon(
 icon: const Icon(Icons.check_circle_outline, color: Colors.white),
 label: const Text("Registrar Ponto", style: TextStyle(fontSize: 18, color: Colors.white)),
 onPressed: () => _registrarPonto(context),
style: ElevatedButton.styleFrom(
 backgroundColor: primaryColor,
 padding: const EdgeInsets.symmetric(vertical: 15),
 shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(12),
 ),
 ),
 ),
),
 const SizedBox(height: 20),

 // BOTÃO 2: Ver Mapa (Desativado)
 SizedBox(
 width: double.infinity,
 child: OutlinedButton.icon(
 icon: Icon(Icons.map_outlined, color: Colors.grey),
 label: const Text("Ver Mapa de Localização (Desativado)", style: TextStyle(fontSize: 18, color: Colors.grey)),
 onPressed: () {
                        _showSnackBar(context, "A função de Mapa está desativada para manutenção.", isSuccess: false);
                    },
style: OutlinedButton.styleFrom(
 padding: const EdgeInsets.symmetric(vertical: 15),
shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(12),
),
side: const BorderSide(color: Colors.grey, width: 2),
 ),
 ),
 ),
],
 ),
 ),
 ),
 );
 }
}