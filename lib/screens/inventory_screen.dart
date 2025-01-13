import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/item.dart';
import 'package:hive/hive.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final Box<Item> inventoryBox = Hive.box<Item>('inventory');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void addItem() {
    final String name = nameController.text;
    final int quantity = int.tryParse(quantityController.text) ?? 0;

    if (name.isNotEmpty && quantity > 0) {
      inventoryBox.add(Item(name: name, quantity: quantity));
      nameController.clear();
      quantityController.clear();
      setState(() {});
    }
  }

  void deleteItem(int index) {
    inventoryBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: addItem,
            child: Text('Add Item'),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: inventoryBox.listenable(),
              builder: (context, Box<Item> box, _) {
                if (box.isEmpty) {
                  return Center(child: Text('No items in inventory.'));
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final item = box.getAt(index);
                    return ListTile(
                      title: Text(item!.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteItem(index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}