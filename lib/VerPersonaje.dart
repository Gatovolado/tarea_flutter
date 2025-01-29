import 'package:flutter/material.dart';
import 'package:tarea_flutter/ListaPersonajes.dart';
import 'package:tarea_flutter/pantalla_personaje2.dart';
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
  void favoriteCharacter(Character? infoCharacter){
    if(infoCharacter != null){
      if (favorites.contains(infoCharacter)){
      favorites.remove(infoCharacter);
      }else{
        favorites.add(infoCharacter);
      }
    }
    setState(() {});
    print(favorites);
  }

  //Icon
  IconData iconHeart = Icons.favorite_border;

  void icon(Character? infoCharacter){
    if (favorites.contains(infoCharacter)){
      iconHeart = Icons.favorite;
    } else{
      iconHeart = Icons.favorite_border;
    } 
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personaje escogido"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("informacion del personaje:\n$listText\nGender: ${widget.infoCharacter.gender}\nCulture: ${widget.infoCharacter.culture}\nBorn: ${widget.infoCharacter.born}"),
            Row(
              children: [
                ElevatedButton.icon(
                      onPressed: (){
                        print("likaso");
                        favoriteCharacter(widget.infoCharacter);
                        icon(widget.infoCharacter);
                      }, 
                      icon: Icon(iconHeart),
                      label: const Text("Like")
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}