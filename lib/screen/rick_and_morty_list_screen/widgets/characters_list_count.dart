import 'package:flutter/widgets.dart';
import 'package:rickandmorty/components/app_colors.dart';

class CharactersListCount extends StatelessWidget {
  const CharactersListCount({super.key, required this.count});

  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Characters List',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.statusColor,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.statusColor,
          ),
        ),
      ],
    );
  }
}
