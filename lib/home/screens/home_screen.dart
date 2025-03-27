import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:textile/home/screens/new_category.dart';
import 'package:textile/home/screens/new_item_screen.dart';
import 'package:textile/home/widgets/category_item_card.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/profile/screens/profile_screen.dart';
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

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  bool _isPageLoading = false;
  final _scrollController = ScrollController();
  late final TabController _tabController;
  late final PageController _pageController;

  void refreshAll() async {
    await ref.read(categoriesProvider.notifier).loadCategories();
    await ref.read(categoryItemsProvider.notifier).loadAllItems(ref.read(userOrgProvider)!.id);

    if (ref.read(categoriesProvider).selectedCategory == null) {
      ref.read(categoryItemsProvider.notifier).loadAllItems(ref.read(userOrgProvider)!.id);
    } else {
      ref.read(categoryItemsProvider.notifier).loadCategoryItems(ref.read(categoriesProvider).selectedCategory!.id);
    }
  }

  // void _scrollToTop() {
  //   _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  // }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isLoading = true;
      });

      await ref.read(categoriesProvider.notifier).loadCategories();
      await ref.read(categoryItemsProvider.notifier).loadAllItems(ref.read(userOrgProvider)!.id);

      // Initialize tab controller after loading categories
      _tabController = TabController(length: ref.read(categoriesProvider).categories.length + 1, vsync: this);

      // Listen to tab changes
      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          _onTabChanged(_tabController.index);
          _pageController.animateToPage(_tabController.index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        }
      });

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) async {
    setState(() {
      _isPageLoading = true;
    });

    if (index == 0) {
      // All items page
      ref.read(categoriesProvider.notifier).selectCategory(null);
      await ref.read(categoryItemsProvider.notifier).loadAllItems(ref.read(userOrgProvider)!.id);
    } else {
      // Category specific page
      final category = ref.read(categoriesProvider).categories[index - 1];
      ref.read(categoriesProvider.notifier).selectCategory(category);
      await ref.read(categoryItemsProvider.notifier).loadCategoryItems(category.id);
    }

    setState(() {
      _isPageLoading = false;
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _isPageLoading = true;
    });
    _tabController.animateTo(page);
  }

  Widget _buildLoadingIndicator() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder:
          (context, index) => Shimmer.fromColors(
            baseColor: AppColors.greyBg,
            highlightColor: AppColors.grey,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          ),
    );
  }

  Widget _buildPageContent(int pageIndex) {
    if (_isPageLoading) {
      return _buildLoadingIndicator();
    }

    if (pageIndex == 0) {
      final items = ref.watch(categoryItemsProvider);
      if (items.isEmpty) {
        return const ItemsEmptyState();
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryItemCard(item: items[index]);
        },
      );
    } else {
      final category = ref.watch(categoriesProvider).categories[pageIndex - 1];
      final items = ref.watch(categoryItemsProvider).where((item) => item.category == category.id).toList();

      if (items.isEmpty) {
        return const ItemsEmptyState();
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryItemCard(item: items[index]);
        },
      );
    }
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
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              upSlideTransition(context, const ProfileScreen());
            },
            icon: SvgPicture.asset("assets/icons/person.svg"),
          ),
        ],
        bottom:
            (ref.watch(categoriesProvider).categories.isEmpty || _isLoading)
                ? null
                : PreferredSize(
                  preferredSize: const Size.fromHeight(40),

                  child: SizedBox(
                    height: 40,
                    child: TabBar(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      padding: EdgeInsets.only(left: 10),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.black,
                      unselectedLabelColor: AppColors.white,
                      indicator: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(100)),
                      tabs: [
                        const Tab(text: 'All'),
                        ...ref.watch(categoriesProvider).categories.map((category) => Tab(text: category.category_name)),
                      ],
                    ),
                  ),
                  // child: Container(
                  //   height: 60,
                  //   color: AppColors.blackbg,
                  //   child: Row(
                  //     children: [
                  //       //Categories TabBar

                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 10),
                  //         child: InkWell(
                  //           onTap: () {
                  //             rightSlideTransition(
                  //               context,
                  //               const NewCategoryScreen(),
                  //               onComplete: () {
                  //                 refreshAll();
                  //               },
                  //             );
                  //           },
                  //           child: DottedBorder(
                  //             color: Colors.white,
                  //             radius: Radius.circular(100),
                  //             borderType: BorderType.RRect,
                  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  //             child: Row(
                  //               children: [
                  //                 Icon(Icons.add, size: 18, color: Colors.white),
                  //                 const SizedBox(width: 4),
                  //                 Text('Add Category', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white)),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          upSlideTransition(
            context,
            const NewItemScreen(),
            onComplete: () {
              refreshAll();
            },
          );
        },
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add),
      ),
      body:
          _isLoading
              ? Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder:
                          (context, index) => Shimmer.fromColors(
                            baseColor: AppColors.greyBg,
                            highlightColor: AppColors.grey,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(100)),
                              margin: const EdgeInsets.only(left: 10),
                            ),
                          ),
                    ),
                  ),

                  _buildLoadingIndicator(),
                ],
              )
              : Column(
                children: [
                  // Search and filter
                  if (ref.watch(categoriesProvider).categories.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: AppColors.grey),
                                  const SizedBox(width: 8),
                                  Text('Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.grey)),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                            onPressed: () {},
                            icon: Icon(Icons.filter_list),
                          ),
                        ],
                      ),
                    ),

                  // PageView for items
                  Expanded(
                    child:
                        ref.watch(categoriesProvider).categories.isEmpty
                            ? const CategoryEmptyState()
                            : PageView.builder(
                              controller: _pageController,
                              onPageChanged: _onPageChanged,
                              itemCount: ref.watch(categoriesProvider).categories.length + 1,
                              itemBuilder: (context, pageIndex) => _buildPageContent(pageIndex),
                            ),
                  ),
                ],
              ),
    );
  }
}
