import 'package:flutter/material.dart';
import 'package:w3_s2_practice/1-START%20CODE/models/course.dart';

class ScoreForm extends StatefulWidget {
  const ScoreForm({super.key});

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();

  String _enterName = '';
  double _enterScore = 0;

  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      _formKey.currentState!.save();

      final newItem = Course(
        name: _enterName,
        score: _enterScore, 
        courseName: 'HTML', 
        studentScores: [],
      );

      Navigator.of(context).pop<StudentInfo>(newItem as StudentInfo?);
    }
  }

  //validate the form
  String? _validateName(String? value) {
    if (value == null || value.isEmpty || value.trim().length > 50) {
      return 'Must be between 1 and 50 characters';
    }
    return null;
  }

  String? _validateScore(String? value) {
    if (value == null || value.isEmpty) {
      return 'Score is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    if (double.parse(value) < 0 || double.parse(value) > 100) {
      return 'Must be a score between 0 and 100';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                initialValue: _enterName,
                validator: _validateName,
                onSaved: (value) {
                  _enterName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Score'),
                initialValue: _enterScore.toString(),
                keyboardType: TextInputType.number,
                validator: _validateScore,
                onSaved: (value) {
                  _enterScore = double.parse(value!);
                },
              ),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Add score'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentInfo {
}
