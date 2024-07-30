import 'package:flutter/material.dart';
import 'register_profile.dart';

class RegisterLocationScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onSave;

  RegisterLocationScreen({required this.formData, required this.onSave});

  @override
  _RegisterLocationScreenState createState() => _RegisterLocationScreenState();
}

class _RegisterLocationScreenState extends State<RegisterLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _city;
  String? _country;

  @override
  void initState() {
    super.initState();
    _city = widget.formData['city'];
    _country = widget.formData['country'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                initialValue: _city,
                onSaved: (value) => _city = value,
                validator: (value) => value!.isEmpty ? 'City is required' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                initialValue: _country,
                onSaved: (value) => _country = value,
                validator: (value) =>
                    value!.isEmpty ? 'Country is required' : null,
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
                          'city': _city,
                          'country': _country,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterProfileScreen(
                              formData: widget.formData,
                              onSave: widget.onSave,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Next'),
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
