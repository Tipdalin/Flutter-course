import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
              label: Text('Title!'),
            ),
          ),
           TextField(
            controller: _titleController,
            textAlign: TextAlign.start,
            maxLines: 1,
            decoration: const InputDecoration(
              label: Text('Amount!'),
              
            ),
          ),
      
          ElevatedButton(
            onPressed: () => {
            print(_titleController.text),
            print(TextEditingController)
          }, child: const Text('Check Amount'))
        ],
      ),
    );
  }
}
