import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/widgets/item_list_tile.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/riverpod/favorite_items.dart';

class ItemDetailsScreen extends ConsumerStatefulWidget {
  final CategoryItemModel item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  ConsumerState<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends ConsumerState<ItemDetailsScreen> {
  bool _favLoading = false;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      imageUrl = await ApiCalls.getImageUrl(widget.item.image);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,

              child: Stack(
                children: [
                  Hero(
                    tag: "${widget.item.name}-${widget.item.id}",
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PhotoView(
                                  maxScale: 1.5,
                                  minScale: 1.0,
                                  imageProvider: NetworkImage(imageUrl!),
                                ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color:
                                        AppTheme
                                            .currentTheme
                                            .colorScheme
                                            .primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color:
                                      AppTheme.currentTheme.colorScheme.error,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 10,
                    // right: 10,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme
                            .currentTheme
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppTheme.currentTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  //Item name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.currentTheme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            _favLoading = true;
                          });
                          await ref
                              .read(favoriteItemsProvider.notifier)
                              .toggleFavorite(widget.item);
                          setState(() {
                            _favLoading = false;
                          });
                        },
                        icon:
                            _favLoading
                                ? const CustomProgressIndicator()
                                : ref
                                    .watch(favoriteItemsProvider)
                                    .items
                                    .any(
                                      (element) => element.id == widget.item.id,
                                    )
                                ? Icon(
                                  Icons.favorite,
                                  color:
                                      AppTheme.currentTheme.colorScheme.error,
                                )
                                : Icon(
                                  Icons.favorite_border,
                                  color:
                                      AppTheme.currentTheme.colorScheme.primary,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //Similar and favourite button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme
                                  .currentTheme
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/similar.svg',
                                  colorFilter: ColorFilter.mode(
                                    AppTheme.currentTheme.colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Similar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        AppTheme
                                            .currentTheme
                                            .colorScheme
                                            .primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme
                                  .currentTheme
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/camera_lens.svg',
                                  colorFilter: ColorFilter.mode(
                                    AppTheme.currentTheme.colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Image Search',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        AppTheme
                                            .currentTheme
                                            .colorScheme
                                            .primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Item description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.currentTheme.colorScheme.secondary,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.currentTheme.colorScheme.tertiary
                              .withOpacity(0.25),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ItemListTile(
                          icon: 'assets/icons/pattern.svg',
                          title: 'Pattern',
                          value:
                              widget.item.pattern.isEmpty
                                  ? '-'
                                  : widget.item.pattern,
                        ),
                        ItemListTile(
                          icon: 'assets/icons/stack.svg',
                          title: 'Material',
                          value:
                              widget.item.material.isEmpty
                                  ? '-'
                                  : widget.item.material,
                        ),
                        ItemListTile(
                          icon: 'assets/icons/weight.svg',
                          title: 'Weight',
                          value:
                              widget.item.gsm == 0
                                  ? '-'
                                  : '${widget.item.gsm} gsm',
                        ),
                        ItemListTile(
                          icon: 'assets/icons/width.svg',
                          title: 'Length',
                          value:
                              widget.item.length == 0
                                  ? '-'
                                  : "${widget.item.length}m",
                        ),
                        ItemListTile(
                          icon: 'assets/icons/hash.svg',
                          title: 'Stock',
                          value:
                              widget.item.stock == 0
                                  ? '-'
                                  : '${widget.item.stock} units',
                        ),
                        ItemListTile(
                          icon: 'assets/icons/rupee.svg',
                          title: 'Price',
                          value:
                              widget.item.price_per_unit == 0
                                  ? '-'
                                  : '₹${widget.item.price_per_unit}/m²',
                          line: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
