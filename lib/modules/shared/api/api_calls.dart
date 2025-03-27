import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:textile/home/models/cateogory_model.dart';
import 'package:textile/home/models/category_item_model.dart';

abstract final class ApiCalls {
  static final supabase = Supabase.instance.client;
  static final User user = supabase.auth.currentUser!;

  static Future<AuthResponse> login() async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: dotenv.env['SUPABASE_EXAMPLE_EMAIL']!,
      password: dotenv.env['SUPABASE_EXAMPLE_PASSWORD']!,
    );

    return res;
  }

  static Future<List> getUserOrg() async {
    final User user = supabase.auth.currentUser!;
    final res = await supabase
        .from('organization_data')
        .select('*')
        .eq('user_id', user.id);
    return res;
  }

  static Future<void> createUserOrg(String orgName) async {
    await supabase.from('organization_data').insert({
      'user_id': user.id,
      'organization_name': orgName,
    });
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    final res = await supabase
        .from('categories')
        .select('*')
        .eq('user_id', user.id);
    return res.map((category) => CategoryModel.fromJson(category)).toList();
  }

  static Future<void> createCategory(String categoryName, int orgId) async {
    await supabase.from('categories').insert({
      'user_id': user.id,
      'category_name':
          categoryName[0].toUpperCase() +
          categoryName.substring(1).toLowerCase(),
      'organization': orgId,
    });
  }

  static Future<List<CategoryItemModel>> getCategoryItems(
    int categoryId,
  ) async {
    final res = await supabase
        .from('category_items')
        .select()
        .eq('category', categoryId);
    return res.map((item) => CategoryItemModel.fromJson(item)).toList();
  }

  static Future<List<CategoryItemModel>> getAllCategoryItems(int orgId) async {
    final res = await supabase
        .from('category_items')
        .select('*')
        .eq('organization_id', orgId);
    return res.map((item) => CategoryItemModel.fromJson(item)).toList();
  }

  static Future<List<FileObject>> getCategoryItemImage(int itemId) async {
    final List<FileObject> images =
        await supabase.storage.from('${user.id}/$itemId').list();
    return images;
  }

  static Future<List<CategoryItemModel>> filteredItems({
    required int orgId,
    required String column,
    required String value,
  }) async {
    final res = await supabase
        .from('category_items')
        .select('*')
        .eq('organization_id', orgId)
        .ilike(column, "%$value%");
    return res.map((item) => CategoryItemModel.fromJson(item)).toList();
  }

  static Future<List<CategoryItemModel>> filteredQtyItems({
    required int orgId,
    required String column,
    required int value,
    int range = 25,
  }) async {
    final res = await supabase
        .from('category_items')
        .select('*')
        .eq('organization_id', orgId)
        .eq(column, value);
    return res.map((item) => CategoryItemModel.fromJson(item)).toList();
  }

  static Future<void> createCategoryItem(
    CategoryItemModel item,
    int orgId,
  ) async {
    await supabase.from('category_items').insert({
      'category': item.category,
      'organization_id': orgId,
      'name': item.name,
      'material':
          (item.material[0].toUpperCase() +
                  item.material.substring(1).toLowerCase())
              .trim(),
      'pattern':
          (item.pattern[0].toUpperCase() +
                  item.pattern.substring(1).toLowerCase())
              .trim(),
      'type': item.type,
      'gsm': item.gsm,
      'length': item.length,
      'stock': item.stock,
      'price_per_unit': item.price_per_unit,
    });
  }

  static Future<void> updateCategoryName(int categoryId, String newName) async {
    await supabase
        .from('categories')
        .update({'category_name': newName})
        .eq('id', categoryId);
  }
}
