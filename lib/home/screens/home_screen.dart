import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:textile/home/widgets/category_item_card.dart';
import 'package:textile/riverpod/categories_rvpd.dart';
import 'package:textile/riverpod/category_items_rvpd.dart';
import 'package:textile/home/widgets/category_empty_state.dart';
import 'package:textile/home/widgets/items_empty_state.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final stopwatch = Stopwatch()..start();
  bool _isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isLoading = true;
      });

      await ref.read(categoriesProvider.notifier).loadCategories();
      await ref
          .read(categoryItemsProvider.notifier)
          .loadAllItems(ref.read(userOrgProvider)!.id);

      stopwatch.stop();
      setState(() {
        _isLoading = false;
      });
      print('Total load time: ${stopwatch.elapsedMilliseconds}ms');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bentoventry'),
            if (ref.watch(userOrgProvider) != null)
              Text(
                ref.watch(userOrgProvider)!.organization_name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                ),
              ),
          ],
        ),
      ),
      body:
          _isLoading
              ? ListView.builder(
                itemCount: 10,
                itemBuilder:
                    (context, index) => Shimmer.fromColors(
                      baseColor: AppColors.greyBg,
                      highlightColor: AppColors.grey,
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        color: AppColors.greyBg,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),
              )
              : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ref.watch(categoriesProvider).categories.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.greyBg,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.search, color: AppColors.grey),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.greyBg,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.filter_list),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${ref.watch(categoryItemsProvider).length} items found in ${(stopwatch.elapsed.inMilliseconds / 1000).toStringAsFixed(2)} sec',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    if (ref.watch(categoriesProvider).categories.isNotEmpty)
                      Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount:
                              ref.watch(categoriesProvider).categories.length +
                              1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              final selectedCategory =
                                  ref
                                      .watch(categoriesProvider)
                                      .selectedCategory;
                              final isAllSelected = selectedCategory == null;

                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: FilledButton(
                                  onPressed: () {
                                    // Clear the selected category when "All" is clicked
                                    ref
                                        .read(categoriesProvider.notifier)
                                        .selectCategory(
                                          null,
                                        ); // Using -1 to clear selection
                                    ref
                                        .read(categoryItemsProvider.notifier)
                                        .loadAllItems(
                                          ref.read(userOrgProvider)!.id,
                                        );
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor:
                                        isAllSelected
                                            ? AppColors.white
                                            : AppColors.greyBg,
                                    foregroundColor:
                                        isAllSelected
                                            ? AppColors.black
                                            : AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'All',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final category =
                                ref.watch(categoriesProvider).categories[index -
                                    1];
                            final selectedCategory =
                                ref.watch(categoriesProvider).selectedCategory;
                            final isSelected =
                                selectedCategory?.id == category.id;

                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: OutlinedButton(
                                onPressed: () {
                                  ref
                                      .read(categoriesProvider.notifier)
                                      .selectCategory(category);
                                  ref
                                      .read(categoryItemsProvider.notifier)
                                      .loadCategoryItems(category.id);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      isSelected ? AppColors.white : null,
                                  foregroundColor:
                                      isSelected
                                          ? AppColors.black
                                          : AppColors.white,
                                  side: BorderSide(
                                    color:
                                        isSelected
                                            ? AppColors.white
                                            : AppColors.white30,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  category.category_name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (ref.watch(categoriesProvider).categories.isEmpty)
                      const CategoryEmptyState(),
                    if (ref.watch(categoriesProvider).categories.isNotEmpty &&
                        ref.watch(categoryItemsProvider).isEmpty)
                      const ItemsEmptyState(),
                    if (ref.watch(categoryItemsProvider).isNotEmpty)
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            stopwatch.reset();
                            stopwatch.start();
                            ref
                                .read(categoryItemsProvider.notifier)
                                .loadAllItems(ref.read(userOrgProvider)!.id);
                            stopwatch.stop();
                          },
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: ref.watch(categoryItemsProvider).length,
                            itemBuilder: (context, index) {
                              return CategoryItemCard(
                                item: ref.watch(categoryItemsProvider)[index],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
    );
  }
}
