// lib/controllers/ponto_controller.dart

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../models/location_points.dart';

class PontoController {
  
  // Função para pegar a localização atual, data e hora
  Future<LocationPoints> getCurrentLocation() async {
    // 1. Lógica de Permissões
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw Exception("Permissão de localização negada. Verifique as configurações do App.");
        }
    }

    // 2. Pega a posição real
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    
    final now = DateTime.now();
    final dateStr = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
    
    // 3. Retorna o modelo LocationPoints com a descrição completa
    return LocationPoints(
      latitude: position.latitude,
      longitude: position.longitude,
      descricao: "Ponto em $dateStr - Lat: ${position.latitude.toStringAsFixed(4)}", timeStamp: '',
    );
  }
}