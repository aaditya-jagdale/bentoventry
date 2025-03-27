import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/screens/item_details_screen.dart';
import 'package:textile/home/widgets/similar_bottomsheet.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class CategoryItemCard extends StatelessWidget {
  final CategoryItemModel item;
  const CategoryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fadeTransition(context, ItemDetailsScreen(item: item));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Hero(
              tag: "${item.name}-${item.id}",

              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${item.material} · ${item.length}m · ${item.stock} units",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.white.withOpacity(0.1),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        backgroundColor: AppColors.white,
                        builder: (context) => SimilarBottomSheet(item: item),
                      );
                    },
                    icon: SvgPicture.asset('assets/icons/similar.svg'),
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
