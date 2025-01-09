import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

enum Mode2 { normal, selection }

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> groceryItems = [];
  Mode2 _currentMode = Mode2.normal;
  final Set<GroceryItem> _selectedItems = {};

  Future<void> _addItem() async {
    GroceryItem? item = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemForm(mode: Mode.creating),
      ),
    );

    if (item != null) {
      setState(() {
        groceryItems.add(item);
      });
    }
  }

  //Edit mode
  Future<void> _editItem(GroceryItem item) async {
    GroceryItem? editedItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
            builder: (ctx) => NewItemForm(
                  mode: Mode.editing,
                  editedItem: item,
                )));
    if (editedItem != null) {
      setState(() {
        int index = groceryItems.indexWhere((element) => element.id == item.id);
        if (index != -1) {
          groceryItems[index] = editedItem;
        }
      });
    }
  }

  //reorder Item
  void _reoderItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final GroceryItem item = groceryItems.removeAt(oldIndex);
      groceryItems.insert(newIndex, item);
    });
  }

// selected check box
  void _toggleSelectedMode() {
    setState(() {
      _currentMode =
          _currentMode == Mode2.normal ? Mode2.selection : Mode2.normal;
      _selectedItems.clear();
    });
  }

  //selection item
  void _toggleItemSelection(GroceryItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }
//remove item
void _removeSelectedItem() {
  setState(() {
    groceryItems.removeWhere((item) => _selectedItems.contains(item));
    _toggleSelectedMode();
  });
}
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (groceryItems.isNotEmpty) {
      content = ReorderableListView(
        onReorder: _reoderItems,
        children: [
          for (int index = 0; index < groceryItems.length; index++)
            ListTile(
              key: ValueKey(groceryItems[index]),
              title: Text(groceryItems[index].name),
              leading: _currentMode == Mode2.selection
                  ? Checkbox(
                      value: _selectedItems.contains(groceryItems[index]),
                      onChanged: (bool? value) {
                        _toggleItemSelection(groceryItems[index]);
                      },
                    )
                  : null,
              onTap: _currentMode == Mode2.normal
                  ? () => _editItem(groceryItems[index])
                  : () => _toggleItemSelection(groceryItems[index]),
              onLongPress: _currentMode == Mode2.normal
                  ? () => _toggleSelectedMode()
                  : null,
              selected: _selectedItems.contains(groceryItems[index]),
            ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentMode == Mode2.normal
            ? 'Your Groceries'
            : '${_selectedItems.length} selected'),
        leading: _currentMode == Mode2.selection
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleSelectedMode,
              )
            : null,
        actions: [
          if (_currentMode == Mode2.normal)
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            ),
          if (_currentMode == Mode2.selection)
            IconButton(
              onPressed: _removeSelectedItem,
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(this.groceryItem, {super.key});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(groceryItem),
      title: Text(groceryItem.name),
      onTap: () => Mode.creating,
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
    );
  }
}
