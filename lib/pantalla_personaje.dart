import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tarea_flutter/personaje.dart';
import 'package:http/http.dart' as http;

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}
class _CharacterScreenState extends State<CharacterScreen>{
  String characterText = "";

  @override
  void initState(){
    downloadCharacter();
    
    super.initState();
  }
  
  void downloadCharacter() async {
    //en total hay 2134 personajes
    final url = Uri.parse("https://anapioficeandfire.com/api/characters/583");
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final json = response.body;
      Character character = Character.fromJson(jsonDecode(json));
      characterText = "${character.name}\n${character.gender}\n${character.culture}\n${character.born}";
    }else{
      characterText = "Error al cargar el personaje";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children:[
            const Text("Personaje aleatorio",
              style: TextStyle(fontSize: 30, color: Colors.black)),
            Text (characterText,
            style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 0, 0))),
            const Padding(padding: EdgeInsets.all(30)),
        
          ]
        ),
      ),
    );
  }
}