import 'package:flutter/material.dart';
import 'package:tarea_flutter/main.dart';
import 'package:tarea_flutter/pantalla_personaje2.dart';
import 'package:tarea_flutter/personaje.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if (favorites.isEmpty) {
      return const Center(
        child: Text("No hay favoritos todavía"),
      );
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Tienes ${favorites.length} personajes favoritos:"),
        ),
        for (var favorito in favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(favorito.name),
          ),
      ],
    );
  }
}