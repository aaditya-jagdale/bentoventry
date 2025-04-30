import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/cateogory_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/textfields.dart';
import 'package:textile/riverpod/categories_rvpd.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class AllCategoriesScreen extends ConsumerStatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  ConsumerState<AllCategoriesScreen> createState() =>
      _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends ConsumerState<AllCategoriesScreen> {
  void _editCategoryBottomSheet(CategoryModel? category) {
    final TextEditingController controller = TextEditingController(
      text: category?.category_name ?? '',
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.currentTheme.colorScheme.secondary,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.currentTheme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                // TextField(
                //   controller: controller,
                //   autofocus: true,
                //   style: TextStyle(
                //     color: AppTheme.currentTheme.colorScheme.secondary,
                //   ),
                //   decoration: InputDecoration(
                //     hintText: 'Category name',
                //     hintStyle: TextStyle(
                //       color: AppTheme.currentTheme.colorScheme.tertiary,
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: AppTheme.currentTheme.colorScheme.tertiary,
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Colors.white),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                CustomTextField(
                  controller: controller,
                  title: '',
                  hint: 'Category name',
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (category != null) {
                        ref
                            .read(categoriesProvider.notifier)
                            .updateCategory(category.id, controller.text);
                      } else {
                        if (controller.text.isNotEmpty) {
                          int orgId = ref.read(userOrgProvider)!.id;
                          await ApiCalls.createCategory(
                            controller.text,
                            orgId,
                          ).then((_) async {
                            await ref
                                .read(categoriesProvider.notifier)
                                .loadCategories();
                          });
                        }
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Done', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Categories')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.currentTheme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          _editCategoryBottomSheet(null);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: ref.watch(categoriesProvider).categories.length,
        itemBuilder: (context, index) {
          final category = ref.watch(categoriesProvider).categories[index];
          return ListTile(
            onTap: () {
              _editCategoryBottomSheet(category);
            },
            title: Text(
              category.category_name,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.currentTheme.colorScheme.primary,
              ),
            ),
            trailing: Icon(
              Icons.mode_edit_outlined,
              color: AppTheme.currentTheme.colorScheme.tertiary,
            ),
          );
        },
      ),
    );
  }
}
