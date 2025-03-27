import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/home/widgets/category_item_card.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  final String column;
  final String value;
  final bool qty;
  const FiltersScreen({
    super.key,
    required this.column,
    required this.value,
    this.qty = false,
  });

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  List<CategoryItemModel> _filteredItems = [];

  @override
  void initState() {
    if (widget.qty) {
      ApiCalls.filteredQtyItems(
        orgId: ref.read(userOrgProvider)!.id,
        column: widget.column,
        value: int.parse(widget.value),
      ).then((value) {
        setState(() {
          _filteredItems = value;
        });
      });
    } else {
      ApiCalls.filteredItems(
        orgId: ref.read(userOrgProvider)!.id,
        column: widget.column,
        value: widget.value,
      ).then((value) {
        setState(() {
          _filteredItems = value;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.column[0].toUpperCase()}${widget.column.substring(1)} : ${widget.value}",
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _filteredItems.length,
        itemBuilder:
            (context, index) => CategoryItemCard(item: _filteredItems[index]),
      ),
    );
  }
}
