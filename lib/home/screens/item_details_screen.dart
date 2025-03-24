import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/widgets/item_list_tile.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class ItemDetailsScreen extends StatefulWidget {
  final CategoryItemModel item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "${widget.item.name}-${widget.item.id}",
              child: Image.asset('assets/images/default.png'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  //Item name
                  Text(
                    widget.item.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              backgroundColor: AppColors.white.withOpacity(0.1),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/similar.svg'),
                                const SizedBox(width: 5),
                                Text(
                                  'Similar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
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
                              backgroundColor: AppColors.white.withOpacity(0.1),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Favourite',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
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
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ItemListTile(
                          icon: 'assets/icons/pattern.svg',
                          title: 'Pattern',
                          value: widget.item.pattern,
                        ),
                        ItemListTile(
                          icon: 'assets/icons/stack.svg',
                          title: 'Material',
                          value: widget.item.material,
                        ),
                        ItemListTile(
                          icon: 'assets/icons/weight.svg',
                          title: 'Weight',
                          value: '${widget.item.gsm} gsm',
                        ),
                        ItemListTile(
                          icon: 'assets/icons/width.svg',
                          title: 'Length',
                          value: "${widget.item.length}m",
                        ),
                        ItemListTile(
                          icon: 'assets/icons/hash.svg',
                          title: 'Stock',
                          value: '${widget.item.stock} units',
                        ),
                        ItemListTile(
                          icon: 'assets/icons/rupee.svg',
                          title: 'Price',
                          value: '₹${widget.item.price_per_unit}/m²',
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
