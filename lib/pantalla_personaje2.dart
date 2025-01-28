import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tarea_flutter/pantalla_favoritos.dart';
import 'package:tarea_flutter/personaje.dart';
import 'package:http/http.dart' as http;

class MenuScreen2 extends StatefulWidget{
  const MenuScreen2({super.key});
  
  @override
  State<MenuScreen2> createState() => _MenuScreen2State();
}

class _MenuScreen2State extends State<MenuScreen2> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CharacterScreen2();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}
var favorites = <Character>[];
class CharacterScreen2 extends StatefulWidget{
  @override
  State<CharacterScreen2> createState() => _CharacterScreen2State();
}

class _CharacterScreen2State extends State<CharacterScreen2> {
  String characterText = "";

  String randomURL = "";

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

  //Favorites
  void favoriteCharacter(Character? character){
    if(character != null){
      if (favorites.contains(character)){
      favorites.remove(character);
      }else{
        favorites.add(character!);
      }
    }
    setState(() {});
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
                    setState(() {});
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