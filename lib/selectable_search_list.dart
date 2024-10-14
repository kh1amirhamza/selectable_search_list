library selectable_search_list;

import 'package:flutter/material.dart';

class ListItem {
  String id;
  String title;
  bool isSelected;

  ListItem({required this.id, required this.title, this.isSelected = false});
}

class MultiSelectListWidget extends StatefulWidget {
  final List<ListItem> items;
  final String searchHint;
  final TextStyle? itemTitleStyle;
  final TextStyle? selectAllTextStyle;
  final Function(List<ListItem>) onItemsSelect;

  const MultiSelectListWidget({
    required this.items,
    this.searchHint = 'Search',
    this.itemTitleStyle,
    this.selectAllTextStyle,
    required this.onItemsSelect,
    super.key,
  });

  @override
  MultiSelectListWidgetState createState() => MultiSelectListWidgetState();
}

class MultiSelectListWidgetState extends State<MultiSelectListWidget> {
  List<ListItem> _filteredItems = [];
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildSearchBar(),
        ),
        CheckboxListTile(
          title: Text(
            'Select All',
            style: widget.selectAllTextStyle,
          ),
          value: _selectAll,
          onChanged: (bool? value) {
            setState(() {
              _selectAll = value ?? false;
              for (var item in _filteredItems) {
                item.isSelected = _selectAll;
              }
            });

            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onItemsSelect(_selectAll ? _filteredItems : []);
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(
                  _filteredItems[index].title,
                  style: widget.itemTitleStyle,
                ),
                value: _filteredItems[index].isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _filteredItems[index].isSelected = value ?? false;
                  });

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    var data = _filteredItems
                        .where((item) => item.isSelected == true)
                        .toList();
                    widget.onItemsSelect(data);

                    if (data.isEmpty) {
                      setState(() {
                        _selectAll = false;
                      });
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.searchHint,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _filteredItems = widget.items
              .where((item) =>
                  item.title.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      },
    );
  }
}
