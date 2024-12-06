import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('AlertDialog Title'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('This is a demo alert dialog.'),
  //               Text('Would you like to approve of this message?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Approve'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  String get title => _titleController.text;

  Category? selectedCategory = Category.food;

  //DropDown Category
  void dropDown(Category? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  //Select Date

  DateTime? selectedDatetime;

  Future<void> dateTime(BuildContext context) async {
    final DateTime? choosedateTime = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2025));
    if (choosedateTime != null) {
      setState(() {
        selectedDatetime = choosedateTime;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  void onAdd() {
    // 1- Get the values from inputs
    String title = _titleController.text;
    double? amount = double.tryParse(_valueController.text);

    //2-Validate the inputs
    bool isTileValid = title.trim().isNotEmpty;
    bool isAmountValid = amount != null && amount > 0;
    bool valid = isAmountValid && isTileValid;

    if (valid) {
      //3.1- Create the expense
      Expense expense = Expense(
          title: title,
          amount: amount,
          date: selectedDatetime ??  DateTime.now(),
          category: selectedCategory ?? Category.leisure);

      // 3.2- Ask the parent to add the expense
      widget.onCreated(expense);

      // 3.3- Close modal
      Navigator.pop(context);
    } else {
      //4.1 Compute the error message
      String errormessage = isTileValid
          ? "The amount shall be positive number"
          : "The tile cannot be empty";

      //4.2 Show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: Text(errormessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('OK'),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              width: 100,
              child: Center(
                child: Text(
                    selectedDatetime == null ? '' : DateFormat('yyyy-MM-dd').format(selectedDatetime!),
                  ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => dateTime(context),
            icon:  Icon(Icons.date_range),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(category.icon),
                          const SizedBox(width: 20),
                          Text(
                            category.toString().split('.').last.toLowerCase(),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: dropDown),
              const SizedBox(
                width: 30,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: onAdd, child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
