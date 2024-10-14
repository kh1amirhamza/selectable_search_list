import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:selectable_search_list/selectable_search_list.dart'; // Import your package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Selectable Search List Example')),
        body: MultiSelectListWidget(
          selectAllTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          itemTitleStyle:  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          items: [
            ListItem(id: '1', title: 'Anything...'),
            ListItem(id: '2', title: 'Something...'),
            ListItem(id: '3', title: 'Nothing..'),
          ],
          onItemsSelect: (selectedItems) {
            print('Selected Items: ${selectedItems.length}');
          },
        ),
      ),
    );
  }
}
