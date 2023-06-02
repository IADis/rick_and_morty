import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/components/app_colors.dart';
import 'package:rickandmorty/model/characters_model.dart';

class CharactersListView extends StatefulWidget {
  const CharactersListView({super.key, required this.character});

  final CharacterModel character;

  @override
  State<CharactersListView> createState() => _CharactersListViewState();
}

class _CharactersListViewState extends State<CharactersListView> {
  Color changeColor(String text) {
    switch (text) {
      case 'Alive':
        return AppColors.statusColor;
      case 'Dead':
        return Colors.red;
      case 'unknown':
        return Colors.lightBlueAccent;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/charactersScreen',
        arguments: widget.character,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.character.image ?? '',
            imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.amber,
              backgroundColor: Colors.black,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.character.status?.toUpperCase() ?? '',
                style: TextStyle(
                    color: changeColor(widget.character.status ?? '')),
              ),
              const SizedBox(height: 10),
              Text(
                widget.character.name ?? '',
                style: const TextStyle(color: AppColors.nameColor),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.character.species}, ${widget.character.gender}',
                style: const TextStyle(color: AppColors.genderColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
