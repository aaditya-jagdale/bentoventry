import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/models/cateogory_model.dart';
import 'package:textile/home/screens/new_category.dart';
import 'package:textile/home/screens/new_item_screen.dart';
import 'package:textile/home/widgets/category_item_card.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
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

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoading = false;
  final bool _isTabLoading = false;
  bool _isFabOpen = false;

  // Animation duration
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final double _fabSpacing = 65.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    setState(() => _isLoading = true);

    await Future.wait([
      ref.read(categoriesProvider.notifier).loadCategories(),
      ref
          .read(categoryItemsProvider.notifier)
          .loadAllItems(ref.read(userOrgProvider)!.id),
    ]);

    _tabController = TabController(
      length: ref.read(categoriesProvider).categories.length + 1,
      vsync: this,
    );
    _tabController!.addListener(_onTabChanged);

    setState(() => _isLoading = false);
  }

  void _onTabChanged() {
    if (!_tabController!.indexIsChanging) {
      final index = _tabController!.index;
      final categoryId =
          index == 0
              ? null
              : ref.read(categoriesProvider).categories[index - 1].id;

      if (index == 0) {
        ref.read(categoriesProvider.notifier).selectCategory(null);
        ref
            .read(categoryItemsProvider.notifier)
            .loadAllItems(ref.read(userOrgProvider)!.id);
      } else {
        final category = ref.read(categoriesProvider).categories[index - 1];
        ref.read(categoriesProvider.notifier).selectCategory(category);
        ref.read(categoryItemsProvider.notifier).loadCategoryItems(category.id);
      }
    }
  }

  Future<void> refreshAll() async {
    ref.read(categoryItemsProvider.notifier).refreshAll();
    await Future.wait([
      ref.read(categoriesProvider.notifier).loadCategories(),
      ref
          .read(categoryItemsProvider.notifier)
          .loadAllItems(ref.read(userOrgProvider)!.id),
    ]);

    if (ref.read(categoriesProvider).selectedCategory != null) {
      await ref
          .read(categoryItemsProvider.notifier)
          .loadCategoryItems(ref.read(categoriesProvider).selectedCategory!.id);
    }
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
    });
  }

  Widget _buildFabItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double index,
  }) {
    return AnimatedPositioned(
      duration: _animationDuration,
      right: 0,
      bottom: _isFabOpen ? (index * _fabSpacing) : 0,
      child: AnimatedOpacity(
        duration: _animationDuration,
        opacity: _isFabOpen ? 1.0 : 0.0,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: AppTheme.currentTheme.colorScheme.primary,
                ),
              ),
            ),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.currentTheme.colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(24),
                  child: Icon(
                    icon,
                    color: AppTheme.currentTheme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.removeListener(_onTabChanged);
    _tabController!.dispose();
    super.dispose();
  }

  Widget _buildLoadingShimmer() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      itemCount: 9,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder:
          (context, index) => Shimmer.fromColors(
            baseColor: AppTheme.currentTheme.colorScheme.primary.withOpacity(
              0.1,
            ),
            highlightColor: AppTheme.currentTheme.colorScheme.primary
                .withOpacity(0.3),
            child: Container(
              // margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
    );
  }

  Widget _buildInitialLoadingState() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder:
                (context, index) => Shimmer.fromColors(
                  baseColor: AppTheme.currentTheme.colorScheme.secondary
                      .withOpacity(0.3),
                  highlightColor: AppTheme.currentTheme.colorScheme.primary,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.currentTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(left: 10),
                  ),
                ),
          ),
        ),
        Expanded(child: _buildLoadingShimmer()),
      ],
    );
  }

  Widget _buildItemsList(List<CategoryItemModel> items) {
    return RefreshIndicator(
      onRefresh: () async {
        //refresh that tab items
        if (ref.read(categoriesProvider).selectedCategory != null) {
          ref
              .read(categoryItemsProvider.notifier)
              .loadCategoryItems(
                ref.read(categoriesProvider).selectedCategory!.id,
              );
        } else {
          ref
              .read(categoryItemsProvider.notifier)
              .loadAllItems(ref.read(userOrgProvider)!.id);
        }
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.5,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CategoryItemCard(item: items[index]);
        },
      ),
    );
  }

  Widget _buildTabContent(
    CategoryItemsState itemsState,
    List<CategoryModel> categories,
  ) {
    if (itemsState.isLoading) {
      return _buildLoadingShimmer();
    }

    return TabBarView(
      controller: _tabController,
      children: [
        itemsState.itemsByCategory[null]?.isEmpty ?? true
            ? const ItemsEmptyState()
            : _buildItemsList(itemsState.itemsByCategory[null] ?? []),
        ...categories.map((category) {
          final categoryItems = itemsState.itemsByCategory[category.id] ?? [];
          return categoryItems.isEmpty
              ? const ItemsEmptyState()
              : _buildItemsList(categoryItems);
        }),
        // _buildItemsList(itemsState.itemsByCategory[null] ?? []),
        // ...categories.map(
        //   (category) =>
        //       _buildItemsList(itemsState.itemsByCategory[category.id] ?? []),
        // ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.primary.withOpacity(
                  0.2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppTheme.currentTheme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.currentTheme.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.currentTheme.colorScheme.primary,
              foregroundColor: AppTheme.currentTheme.colorScheme.secondary,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider).categories;
    final itemsState = ref.watch(categoryItemsProvider);
    final userOrg = ref.watch(userOrgProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bentoventry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (userOrg != null)
              Text(
                userOrg.organization_name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.currentTheme.colorScheme.tertiary,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed:
                () => upSlideTransition(
                  context,
                  const ProfileScreen(),
                  onComplete: () => setState(() {}),
                ),
            icon: SvgPicture.asset(
              "assets/icons/person.svg",
              colorFilter: ColorFilter.mode(
                AppTheme.currentTheme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ...[
              _buildFabItem(
                icon: Icons.category,
                label: 'Add Category',
                onTap: () {
                  _toggleFab();
                  upSlideTransition(
                    context,
                    const NewCategoryScreen(),
                    onComplete: refreshAll,
                  );
                },
                index: 2,
              ),
              _buildFabItem(
                icon: Icons.add,
                label: 'Add Item',
                onTap: () {
                  _toggleFab();
                  upSlideTransition(
                    context,
                    const NewItemScreen(),
                    onComplete: refreshAll,
                  );
                },
                index: 1,
              ),
            ],
            FloatingActionButton(
              onPressed: _toggleFab,
              backgroundColor: AppTheme.currentTheme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: AnimatedRotation(
                duration: _animationDuration,
                turns: _isFabOpen ? 0.125 : 0,
                child: Icon(
                  Icons.add,
                  color: AppTheme.currentTheme.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
      body:
          _isLoading
              ? _buildInitialLoadingState()
              : Column(
                children: [
                  if (categories.isNotEmpty) _buildSearchBar(),
                  if (categories.isNotEmpty)
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TabBar(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: _tabController,
                        isScrollable: true,
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.transparent,
                        padding: const EdgeInsets.only(left: 10),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppTheme.currentTheme.colorScheme.secondary,
                        unselectedLabelColor:
                            AppTheme.currentTheme.colorScheme.primary,
                        indicator: BoxDecoration(
                          color: AppTheme.currentTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tabs: [
                          const Tab(text: 'All'),
                          ...categories.map(
                            (category) => Tab(text: category.category_name),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child:
                        categories.isEmpty
                            ? const CategoryEmptyState()
                            : _buildTabContent(itemsState, categories),
                  ),
                ],
              ),
    );
  }
}
