import 'package:flutter/material.dart';
import 'package:tarea_flutter/pantalla_personaje2.dart';

void main() {
  runApp(const Aplication());
}

class Aplication extends StatelessWidget {
  const Aplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personajes GOT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 110, 173, 255)),
        useMaterial3: true, 
      ),
      home: const MenuScreen2(),
    );
  }
}
class MyAppState extends ChangeNotifier{
  
}
