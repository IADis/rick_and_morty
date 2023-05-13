import '../screen/rick_and_morty_detail_screen/rick_and_morty_detail_screen.dart';
import '../screen/rick_and_morty_list_screen/rick_and_morty_list_screen.dart';

final routes = {
  '/': (context) => const RickAndMortyListScreen(),
  '/coinScreen': (context) => const RickAndMortyDetailScreen(),
};
