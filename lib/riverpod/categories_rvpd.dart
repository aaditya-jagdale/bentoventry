import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/cateogory_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';

class CategoryState {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  CategoryState({required this.categories, this.selectedCategory});

  CategoryState copyWith({CategoryModel? selectedCategory}) {
    return CategoryState(
      categories: categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoryState>((ref) {
      return CategoriesNotifier();
    });

class CategoriesNotifier extends StateNotifier<CategoryState> {
  CategoriesNotifier()
    : super(CategoryState(categories: [], selectedCategory: null)) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categories = await ApiCalls.getAllCategories();
    state = CategoryState(categories: categories, selectedCategory: null);
  }

  void selectCategory(CategoryModel? category) {
    state = state.copyWith(
      selectedCategory: category,
    );
  }

  Future<void> addCategory(String categoryName) async {
    await ApiCalls.createCategory(categoryName);
  }
}
