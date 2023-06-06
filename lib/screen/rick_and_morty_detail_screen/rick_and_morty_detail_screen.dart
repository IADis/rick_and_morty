import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rickandmorty/components/app_colors.dart';
import 'package:rickandmorty/model/characters_model.dart';

class RickAndMortyDetailScreen extends StatelessWidget {
  const RickAndMortyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as CharacterModel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 350,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(arguments.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff0B1E2D).withOpacity(0.2)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 100,
                child: Container(
                  height: 190,
                  width: 190,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff0B1E2D), width: 8),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(arguments.image ?? ''),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              arguments.name ?? '',
              style: const TextStyle(
                color: AppColors.nameColor,
                fontSize: 35,
              ),
            ),
          ),
          Center(
            child: Text(
              arguments.status ?? '',
              style: const TextStyle(
                color: AppColors.statusColor,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Floor',
                  style: TextStyle(
                    color: Color(0xff5B6975),
                    fontSize: 17,
                  ),
                ),
                Text(
                  'Species',
                  style: TextStyle(
                    color: Color(0xff5B6975),
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  arguments.gender ?? '',
                  style: const TextStyle(
                    color: AppColors.nameColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  arguments.species ?? '',
                  style: const TextStyle(
                    color: AppColors.nameColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Place of birth',
              style: TextStyle(
                color: Color(0xff5B6975),
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              arguments.origin?.name ?? '',
              style: const TextStyle(
                color: AppColors.nameColor,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Location',
              style: TextStyle(
                color: Color(0xff5B6975),
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              arguments.location?.name ?? '',
              style: const TextStyle(
                color: AppColors.nameColor,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
