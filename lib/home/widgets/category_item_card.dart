import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/screens/item_details_screen.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/riverpod/image_urls_rvpd.dart';

class CategoryItemCard extends ConsumerStatefulWidget {
  final CategoryItemModel item;
  const CategoryItemCard({super.key, required this.item});

  @override
  ConsumerState<CategoryItemCard> createState() => _CategoryItemCardState();
}

class _CategoryItemCardState extends ConsumerState<CategoryItemCard> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlFuture = ref
        .read(imageUrlsProvider.notifier)
        .getImageUrl(widget.item.id, widget.item.image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fadeTransition(context, ItemDetailsScreen(item: widget.item));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 10),
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: AppTheme.currentTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x26FFFFFF),
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${widget.item.name}-${widget.item.id}",
              child: Container(
                width: double.infinity,
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  color: AppTheme.currentTheme.colorScheme.tertiary.withOpacity(
                    0.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x0CFFFFFF),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: FutureBuilder<String>(
                  future: _imageUrlFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Shimmer.fromColors(
                            baseColor: AppTheme.currentTheme.colorScheme.primary
                                .withOpacity(0.1),
                            highlightColor: AppTheme
                                .currentTheme
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.grey[300]!,
                            ),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      return Center(
                        child: Icon(
                          Icons.error_outline,
                          color: AppTheme.currentTheme.colorScheme.error,
                        ),
                      );
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Center(
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Shimmer.fromColors(
                                  baseColor: AppTheme
                                      .currentTheme
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  highlightColor: AppTheme
                                      .currentTheme
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => Center(
                              child: Icon(
                                Icons.error_outline,
                                color: AppTheme.currentTheme.colorScheme.error,
                              ),
                            ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      widget.item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppTheme.currentTheme.colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: DottedLine(
                      lineThickness: 1,
                      dashColor: AppTheme.currentTheme.colorScheme.tertiary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                "assets/icons/width.svg",
                                colorFilter: ColorFilter.mode(
                                  AppTheme.currentTheme.colorScheme.primary
                                      .withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${widget.item.length}m',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                "assets/icons/container.svg",
                                colorFilter: ColorFilter.mode(
                                  AppTheme.currentTheme.colorScheme.primary
                                      .withOpacity(0.5),
                                  BlendMode.srcIn,
                                ),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${widget.item.stock} units',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF808080),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
