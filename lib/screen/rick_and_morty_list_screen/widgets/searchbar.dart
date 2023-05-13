import 'package:flutter/material.dart';
import 'package:rickandmorty/components/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onChanged});

  final Function(String name) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(
        color: AppColors.nameColor,
      ),
      decoration: InputDecoration(
        hintText: 'Find a character',
        hintStyle: const TextStyle(
          color: AppColors.nameColor,
        ),
        contentPadding: const EdgeInsets.all(20),
        fillColor: AppColors.backgroundColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.statusColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.statusColor,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
