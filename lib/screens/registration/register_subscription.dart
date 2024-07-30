import 'package:flutter/material.dart';

class RegisterSubscriptionScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onSave;

  RegisterSubscriptionScreen({required this.formData, required this.onSave});

  @override
  _RegisterSubscriptionScreenState createState() =>
      _RegisterSubscriptionScreenState();
}

class _RegisterSubscriptionScreenState
    extends State<RegisterSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _package;

  @override
  void initState() {
    super.initState();
    _package = widget.formData['package'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subscription')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Subscription Package'),
                value: _package,
                items: ['Free', 'Premium']
                    .map((pkg) => DropdownMenuItem(
                          value: pkg,
                          child: Text(pkg),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _package = value),
                validator: (value) =>
                    value == null ? 'Package is required' : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.onSave({
                          'package': _package,
                        });
                        // Submit the form data here
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Registration Completed!'),
                        ));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
