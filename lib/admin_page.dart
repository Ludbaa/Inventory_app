import 'package:flutter/material.dart';

class Item {
  String name;
  Item(this.name);
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Item> items = List.generate(
      10, (index) => Item('Item ${index + 1}')); // Predefined items
  int? selectedIndex; // To keep track of the selected item for editing

  void _addItem(String name) {
    setState(() {
      items.add(Item(name));
    });
  }

  void _editItem(int index, String newName) {
    setState(() {
      items[index].name = newName;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _showAddEditDialog({int? index}) {
    final TextEditingController controller = TextEditingController();
    if (index != null) {
      controller.text = items[index].name;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Item' : 'Edit Item'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (index == null) {
                  _addItem(controller.text);
                } else {
                  _editItem(index, controller.text);
                }
                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            onTap: () {
              setState(() {
                selectedIndex = index; // Set the selected index for editing
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.green), // Add icon color
              onPressed: () => _showAddEditDialog(),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue), // Edit icon color
              onPressed: selectedIndex != null
                  ? () => _showAddEditDialog(index: selectedIndex)
                  : null, // Disable if no item is selected
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red), // Delete icon color
              onPressed: selectedIndex != null
                  ? () {
                      _deleteItem(selectedIndex!);
                      setState(() {
                        selectedIndex =
                            null; // Reset selected index after deletion
                      });
                    }
                  : null, // Disable if no item is selected
            ),
          ],
        ),
      ),
    );
  }
}
