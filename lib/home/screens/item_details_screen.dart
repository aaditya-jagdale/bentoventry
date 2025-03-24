import 'package:flutter/material.dart';
import 'package:textile/home/models/category_item_model.dart';

class ItemDetailsScreen extends StatefulWidget {
  final CategoryItemModel item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.item.name)));
  }
}
