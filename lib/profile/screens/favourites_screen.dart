import 'package:flutter/material.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<CategoryItemModel> _favourites = [];

  Future<void> loadFavourites() async {
    final favourites = await ApiCalls.getAllFavorites();
    setState(() {
      _favourites = favourites;
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Column(children: [Text(_favourites.toString())]),
      // _favourites.isEmpty
      //     ? const Center(child: Text('No favorites found'))
      //     : ListView.builder(
      //       itemCount: _favourites.length,
      //       itemBuilder: (context, index) {
      //         return Text(
      //           // _favourites[index].name,
      //           "Test",
      //           style: TextStyle(
      //             color: AppTheme.currentTheme.colorScheme.primary,
      //           ),
      //         );
      //       },
      //     ),
    );
  }
}
