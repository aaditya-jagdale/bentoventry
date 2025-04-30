import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

class CategoryItemsState {
  final Map<int?, List<CategoryItemModel>> itemsByCategory;
  final Set<int?> loadedCategories;
  final bool isLoading;

  CategoryItemsState({this.itemsByCategory = const {}, this.loadedCategories = const {}, this.isLoading = false});

  CategoryItemsState copyWith({Map<int?, List<CategoryItemModel>>? itemsByCategory, Set<int?>? loadedCategories, bool? isLoading}) {
    return CategoryItemsState(
      itemsByCategory: itemsByCategory ?? this.itemsByCategory,
      loadedCategories: loadedCategories ?? this.loadedCategories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final categoryItemsProvider = StateNotifierProvider<CategoryItemsNotifier, CategoryItemsState>((ref) {
  return CategoryItemsNotifier();
});

class CategoryItemsNotifier extends StateNotifier<CategoryItemsState> {
  CategoryItemsNotifier() : super(CategoryItemsState());

  Future<void> loadCategoryItems(int categoryId) async {
    if (state.loadedCategories.contains(categoryId)) return;

    state = state.copyWith(isLoading: true);
    try {
      final items = await ApiCalls.getCategoryItems(categoryId);
      final newItemsByCategory = Map<int?, List<CategoryItemModel>>.from(state.itemsByCategory);
      newItemsByCategory[categoryId] = items;

      final newLoadedCategories = Set<int?>.from(state.loadedCategories)..add(categoryId);

      state = state.copyWith(itemsByCategory: newItemsByCategory, loadedCategories: newLoadedCategories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> loadAllItems(int orgId) async {
    if (state.loadedCategories.contains(null)) return;

    state = state.copyWith(isLoading: true);
    try {
      final items = await ApiCalls.getAllCategoryItems(orgId);
      final newItemsByCategory = Map<int?, List<CategoryItemModel>>.from(state.itemsByCategory);
      newItemsByCategory[null] = items;

      final newLoadedCategories = Set<int?>.from(state.loadedCategories)..add(null);

      state = state.copyWith(itemsByCategory: newItemsByCategory, loadedCategories: newLoadedCategories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> addCategoryItem(CategoryItemModel item) async {
    // await ApiCalls.createCategoryItem(item);
    await loadCategoryItems(item.category);
  }

  void refreshCategory(int? categoryId) {
    final newLoadedCategories = Set<int?>.from(state.loadedCategories)..remove(categoryId);
    final newItemsByCategory = Map<int?, List<CategoryItemModel>>.from(state.itemsByCategory)..remove(categoryId);

    state = state.copyWith(loadedCategories: newLoadedCategories, itemsByCategory: newItemsByCategory);
  }

  void refreshAll() {
    state = CategoryItemsState();
  }
}
