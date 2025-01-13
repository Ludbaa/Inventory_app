import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/item.dart';

class IncomingItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Box<Item> inventoryBox = Hive.box<Item>('inventory');

    return Scaffold(
      appBar: AppBar(title: Text('Incoming Items')),
      body: ValueListenableBuilder(
        valueListenable: inventoryBox.listenable(),
        builder: (context, Box<Item> box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No incoming items.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);
              return ListTile(
                title: Text(item!.name),
                subtitle: Text('Quantity: ${item.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}