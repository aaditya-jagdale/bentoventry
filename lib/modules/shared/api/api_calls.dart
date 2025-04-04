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

  static Future<void> createCategory(String categoryName) async {
    await supabase.from('categories').insert({
      'user_id': user.id,
      'category_name': categoryName,
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
}
