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
    : super(CategoryState(categories: [], selectedCategory: null));

  Future<void> loadCategories() async {
    final categories = await ApiCalls.getAllCategories();
    state = CategoryState(categories: categories, selectedCategory: null);
  }

  void selectCategory(CategoryModel? category) {
    state = CategoryState(
      categories: state.categories,
      selectedCategory: category,
    );
  }

  void updateName(int categoryId, String newName) {
    final categories = [...state.categories];
    final index = categories.indexWhere((element) => element.id == categoryId);
    categories[index] = CategoryModel(
      id: categories[index].id,
      category_name: newName,
      user_id: categories[index].user_id,
      organization: categories[index].organization,
    );
    state = CategoryState(
      categories: categories,
      selectedCategory: state.selectedCategory,
    );
  }

  Future<void> updateCategory(int categoryId, String newName) async {
    await ApiCalls.updateCategoryName(categoryId, newName);
    updateName(categoryId, newName);
  }

  Future<void> addCategory(String categoryName, int orgId) async {
    await ApiCalls.createCategory(categoryName, orgId);
  }
}
