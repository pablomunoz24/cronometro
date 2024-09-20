import 'package:flutter/material.dart';
import 'dart:async';

class Temporizador extends StatefulWidget {
  const Temporizador({super.key});

  @override
  State<Temporizador> createState() => _TemporizadorState();
}

class _TemporizadorState extends State<Temporizador> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false; // Controla si el cronómetro está en funcionamiento

  // Función para iniciar el cronómetro
  void _startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
  }

  // Función para detener el cronómetro
  void _stopTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer.cancel();
    }
  }

  // Función para formatear los segundos a minutos y segundos
  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel(); // Asegurarse de cancelar el temporizador cuando el widget se elimina
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tiempo: ${_formatTime(_seconds)}',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text('Iniciar Cronómetro'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _stopTimer,
              child: const Text('Detener Cronómetro'),
            ),
          ],
        ),
      ),
    );
  }
}