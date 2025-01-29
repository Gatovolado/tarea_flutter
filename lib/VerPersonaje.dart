import 'package:flutter/material.dart';
import 'package:tarea_flutter/ListaPersonajes.dart';
import 'package:tarea_flutter/personaje.dart';
Character? character;
class verPersonaje extends StatefulWidget{

  final String title;
  final Character infoCharacter;

  const verPersonaje({super.key, required this.title, required this.infoCharacter});

  @override
  State<verPersonaje> createState() => _verPersonajeState();
}
String alias = "";
void Alias(){
  if (character!.aliases.isNotEmpty){
    alias = character!.aliases[0];
  }
}

class _verPersonajeState extends State<verPersonaje> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personaje escogido"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("informacion del personaje:\n$listText\nGender: ${widget.infoCharacter.gender}\nCulture: ${widget.infoCharacter.culture}\nBorn: ${widget.infoCharacter.born}")
          ],
        ),
      ),
    );
  }
}