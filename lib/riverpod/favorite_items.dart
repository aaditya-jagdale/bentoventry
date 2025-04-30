import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

class FavoriteItemsState {
  final List<CategoryItemModel> items;
  final bool isLoading;

  FavoriteItemsState({this.items = const [], this.isLoading = false});

  FavoriteItemsState copyWith({
    List<CategoryItemModel>? items,
    bool? isLoading,
  }) {
    return FavoriteItemsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final favoriteItemsProvider =
    StateNotifierProvider<FavoriteItemsNotifier, FavoriteItemsState>((ref) {
      return FavoriteItemsNotifier();
    });

class FavoriteItemsNotifier extends StateNotifier<FavoriteItemsState> {
  FavoriteItemsNotifier() : super(FavoriteItemsState());

  Future<void> loadFavoriteItems() async {
    state = state.copyWith(isLoading: true);
    try {
      final items = await ApiCalls.getAllFavorites();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> toggleFavorite(CategoryItemModel item) async {
    final isFavorite = await ApiCalls.toggleItemFromFavorites(item.id);
    if (isFavorite) {
      state = state.copyWith(items: [...state.items, item]);
    } else {
      state = state.copyWith(
        items: state.items.where((element) => element.id != item.id).toList(),
      );
    }
  }
}
