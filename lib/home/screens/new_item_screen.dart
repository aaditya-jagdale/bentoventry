import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/models/cateogory_model.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/modules/shared/widgets/snackbars.dart';
import 'package:textile/modules/shared/widgets/textfields.dart';
import 'package:textile/riverpod/categories_rvpd.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class NewItemScreen extends ConsumerStatefulWidget {
  const NewItemScreen({super.key});

  @override
  ConsumerState<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends ConsumerState<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _materialController = TextEditingController();
  final _patternController = TextEditingController();
  final _typeController = TextEditingController();
  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockQtyController = TextEditingController();
  List<String> selectedTags = ['Cotton', 'Stripe', 'Indian', 'Silk', 'Linen'];
  List<String> selectedPhotos = [];
  CategoryModel? selectedCategory;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the category controller with empty text
    _categoryController.text = '';
  }

  void _handleSubmit() {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        errorSnackBar(context, 'Please select a category');
        return;
      }

      // All fields are valid
      final newItem = {
        'category': selectedCategory!.id,
        'name': _itemNameController.text,
        'material':
            _materialController.text[0].toUpperCase() +
            _materialController.text.substring(1).toLowerCase(),
        'pattern':
            _patternController.text[0].toUpperCase() +
            _patternController.text.substring(1).toLowerCase(),
        'type': _typeController.text,
        'stock': int.parse(_stockQtyController.text),
        'length': int.parse(_lengthController.text),
        'gsm': int.parse(_weightController.text),
        'price_per_unit': int.parse(_priceController.text),
        // 'search_tags': selectedTags,
      };

      final categoryItem = CategoryItemModel.fromJson(newItem);
      final orgId = ref.read(userOrgProvider)!.id;
      ApiCalls.createCategoryItem(categoryItem, orgId).then((_) {
        // Show success message
        successSnackBar(context, 'Item added successfully!');
        Navigator.pop(context);
        setState(() {
          _loading = false;
        });
      });
    } else {
      errorSnackBar(context, 'Please fill in all required fields');
      setState(() {
        _loading = false;
      });
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).categories;

    return Scaffold(
      backgroundColor: AppColors.blackbg,
      appBar: AppBar(
        backgroundColor: AppColors.blackbg,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text('New Item')],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CategoryModel>(
                        value: selectedCategory,
                        hint: Text(
                          'Select Category',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: AppColors.greyBg,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        dropdownColor: AppColors.black,
                        items:
                            categories.map((category) {
                              return DropdownMenuItem<CategoryModel>(
                                value: category,
                                child: Text(
                                  category.category_name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                        onChanged: (CategoryModel? value) {
                          setState(() {
                            selectedCategory = value;
                            _categoryController.text =
                                value?.category_name ?? '';
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (_categoryController.text.isNotEmpty)
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            CustomTextField(
                              title: 'Item name*',
                              controller: _itemNameController,
                              hint: 'Serial no. or name',
                              validator:
                                  (value) =>
                                      _validateRequired(value, 'Item name'),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              title: 'Material*',
                              controller: _materialController,
                              hint: 'Cotton, Linen',
                              validator:
                                  (value) =>
                                      _validateRequired(value, 'Material'),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              title: 'Pattern*',
                              controller: _patternController,
                              hint: 'Checks, Stripe',
                              validator:
                                  (value) =>
                                      _validateRequired(value, 'Pattern'),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              title: 'Type',
                              controller: _typeController,
                              hint: 'Tie Dyed, Block prints',
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    title: 'Stock*',
                                    controller: _stockQtyController,
                                    hint: 'Enter quantity available',
                                    validator:
                                        (value) =>
                                            _validateNumber(value, 'Stock'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    title: 'Length*',
                                    controller: _lengthController,
                                    hint: 'length in meters',
                                    validator:
                                        (value) =>
                                            _validateNumber(value, 'Length'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    title: 'Weight* (gsm)',
                                    controller: _weightController,
                                    hint: 'Material GSM',
                                    validator:
                                        (value) =>
                                            _validateNumber(value, 'Weight'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    title: 'Price* per m²',
                                    controller: _priceController,
                                    hint: 'INR per m²',
                                    validator:
                                        (value) =>
                                            _validateNumber(value, 'Price'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Photos (max 5)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       'Search Tags',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //     const SizedBox(width: 8),
                            //     Icon(
                            //       Icons.help_outline,
                            //       color: Colors.grey[600],
                            //       size: 20,
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 12),
                            // Wrap(
                            //   spacing: 8,
                            //   runSpacing: 8,
                            //   children:
                            //       selectedTags
                            //           .map((tag) => _buildTag(tag))
                            //           .toList(),
                            // ),
                            const SizedBox(height: 24),
                            if (_loading)
                              const Center(child: CustomProgressIndicator())
                            else
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _handleSubmit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Add Item',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(tag, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _itemNameController.dispose();
    _materialController.dispose();
    _patternController.dispose();
    _typeController.dispose();
    _weightController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
