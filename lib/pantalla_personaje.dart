import 'dart:convert';
import 'dart:math';
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
  String randomURL = "";
  @override
  void initState(){
    
    super.initState();
  }
  //random number for the API
  int randomNumber(){
    int x = Random().nextInt(2135);
    return x;
  }
  Character? character;
  //Download a character for the API
  void downloadCharacter() async {
    //en total hay 2134 personajes
    final url = Uri.parse("https://anapioficeandfire.com/api/characters/${randomNumber()}");
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final json = response.body;
      character = Character.fromJson(jsonDecode(json));
      characterText = "Name: ${character?.name}\nGender: ${character?.gender}\nCulture: ${character?.culture}\nBorn: ${character?.born}";
      icon(character);
    }else{
      characterText = "Error al cargar el personaje";
    }
    setState(() {});
  }
  //Favourites
  var favorites = <Character>[];
  void favoriteCharacter(Character? character){
    if(character != null){
      if (favorites.contains(character)){
      favorites.remove(character);
      }else{
        favorites.add(character!);
      }
    }
    print(favorites);
  }
  //Icon
  IconData iconHeart = Icons.favorite_border;
  void icon(Character? character){
    if (favorites.contains(character)){
      iconHeart = Icons.favorite;
    } else{
      iconHeart = Icons.favorite_border;
    } 
    setState(() {});
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Personaje aleatorio",
                style: TextStyle(fontSize: 30, color: Colors.black)),
            ),
            Text (characterText,
            style: const TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 0, 0))),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Fav Button
                ElevatedButton.icon(
                  onPressed: (){
                    print("likaso");
                    favoriteCharacter(character);
                    icon(character);
                  }, 
                  icon: Icon(iconHeart),
                  label: const Text("Like")
                ),
                //Next Button
                ElevatedButton(
                  onPressed: (){
                    print("button pressed!");
                    print(randomURL);
                    downloadCharacter();
                  }, 
                  child: const Text("Next"),
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}