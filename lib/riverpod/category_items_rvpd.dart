import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

final categoryItemsProvider =
    StateNotifierProvider<CategoryItemsNotifier, List<CategoryItemModel>>((
      ref,
    ) {
      return CategoryItemsNotifier();
    });

class CategoryItemsNotifier extends StateNotifier<List<CategoryItemModel>> {
  CategoryItemsNotifier() : super([]);

  Future<void> loadCategoryItems(int categoryId) async {
    final items = await ApiCalls.getCategoryItems(categoryId);
    state = items;
  }

  Future<void> loadAllItems(int orgId) async {
    final items = await ApiCalls.getAllCategoryItems(orgId);
    state = items;
  }

  Future<void> addCategoryItem(CategoryItemModel item) async {
    // await ApiCalls.createCategoryItem(item);
    await loadCategoryItems(item.category);
  }
}
