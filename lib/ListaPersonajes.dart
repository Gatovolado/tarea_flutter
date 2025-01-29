import 'package:flutter/material.dart';
import 'package:tarea_flutter/personaje.dart';
import 'package:tarea_flutter/pantalla_personaje2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CharacterList extends StatefulWidget{
  @override
  State<CharacterList> createState() => _CharacterListState();
  
}

class _CharacterListState extends State<CharacterList> {
  String error = "";
  @override
  void initState() {
    downloadList();
    super.initState();
  }
  int numpage = 1;
  void nextPage(){
    numpage = numpage + 1;
    print(numpage);
    downloadList();
  }

  List<Character> listaPersonajes = [];
  String alias = "";
  String nombre = "";
  void downloadList() async {
    //en total hay 2134 personajes
    final url = Uri.parse("https://www.anapioficeandfire.com/api/characters?page=$numpage&pageSize=10");
    final response = await http.get(url);
    print("response ${response.statusCode}");
    listaPersonajes.clear();
    if(response.statusCode == 200) {
      final json = response.body;
      if (json.isNotEmpty){
        final datos = jsonDecode(json);
        for (var dato in datos){

          final personaje = Character.fromJson(dato);
          listaPersonajes.add(personaje);
        }
      }
    }else{
      error = "Error al cargar el personaje";
    }
    setState(() {});
  }
    int numP = 10; 
  void numeroPersonaje(){
    numP = numP + 10;
  }
  @override
  Widget build(BuildContext context){
    
    return ListView(
      
      children: [
        Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: (){
                nextPage();
                numeroPersonaje();
              }, 
              child: const Text("Next"),
            ),
          ),
        ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("numero de página: $numpage, hasta el persoanje número $numP"),
        ),
        ListView.builder(
          itemCount: listaPersonajes.length,
          itemBuilder: (context, index){
            if (listaPersonajes[index].aliases.isNotEmpty){
            alias = listaPersonajes[index].aliases[0];
            }else{alias = "";}
            if (listaPersonajes[index].name.isNotEmpty){
              nombre = "${listaPersonajes[index].name},";
            }else{nombre = "";}
            String listText = "$nombre $alias";
            return ListTile(title: Text(listText));
            
          },
          shrinkWrap: true,
        )
        
      ],
    );
    
  }
}