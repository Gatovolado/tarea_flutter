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
  String CharacterText = "";

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
      CharacterText = "${character.name}\n${character.gender}\n${character.culture}\n${character.born}";
    }else{
      CharacterText = "Error al cargar el personaje";
    }
    setState(() {});
  }
  
  void character() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CharacterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
              Text (CharacterText,
              style: const TextStyle(fontSize: 30, color: Colors.red)),
          
          TextButton(onPressed: character, child: const Text("Personaje")),
        ]
      ),
    );
  }
}