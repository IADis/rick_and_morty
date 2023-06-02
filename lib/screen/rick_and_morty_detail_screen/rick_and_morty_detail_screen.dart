import 'package:flutter/material.dart';
import 'package:rickandmorty/model/characters_model.dart';

class RickAndMortyDetailScreen extends StatelessWidget {
  const RickAndMortyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as CharacterModel;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              arguments.name.toString(),
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            arguments.status.toString(),
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          Text(
            arguments.gender.toString(),
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
