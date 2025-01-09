import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

const Uuid uuid = Uuid();

enum Mode { creating, editing }

class NewItemForm extends StatefulWidget {
  final Mode mode;
  final GroceryItem? editedItem;

  const NewItemForm({
    super.key,
    required this.mode,
    this.editedItem,
  });

  @override
  State<NewItemForm> createState() {
    return _NewItemFormState();
  }
}

class _NewItemFormState extends State<NewItemForm> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();


  //init name qty and grocery
  String _enteredName = '';
  int _enterQuantity = 0;
  GroceryCategory? _selectedCategory = GroceryCategory.convenience;

  void _saveItem() {
    // 1 - Validate
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      // 2 Save the inputs
      _formKey.currentState!.save();

      // 3  Create the new item
      //String id = uuid.v4();

      final newItem = GroceryItem(
          id: widget.editedItem?.id ?? uuid.v4(),
          name: _enteredName,
          quantity: _enterQuantity,
          category: _selectedCategory!);

      // 4 Return the new item
      Navigator.of(context).pop<GroceryItem>(newItem);
    }
  }

  void initState() {
    super.initState();
    if (widget.mode == Mode.editing && widget.editedItem != null) {
      _enteredName = widget.editedItem!.name;
      _enterQuantity = widget.editedItem!.quantity;
      _selectedCategory = widget.editedItem!.category;
    }else{
      _enteredName = '';
      _enterQuantity = 0;
      _selectedCategory = GroceryCategory.convenience;
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  //Validate Characters
  String? validateTitle(String? value) {
    if (value == null ||
        value.isEmpty ||
        //value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required.';
    }
    //check valid value
    final parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue <= 0) {
      return 'Must be a valid or Positive number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.mode == Mode.creating ? 'Add New Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                //Button name
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      //Button quantity
                      initialValue: _enterQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: validateQuantity,
                      onSaved: (value) {
                        _enterQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCategory = value;
                      },
                      value: _selectedCategory,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child:  Text(widget.mode == Mode.creating ? "Add Item" : 'Edit Item')),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
