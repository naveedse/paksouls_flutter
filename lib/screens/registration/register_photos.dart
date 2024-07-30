import 'package:flutter/material.dart';
import 'register_subscription.dart';

class RegisterPhotosScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onSave;

  RegisterPhotosScreen({required this.formData, required this.onSave});

  @override
  _RegisterPhotosScreenState createState() => _RegisterPhotosScreenState();
}

class _RegisterPhotosScreenState extends State<RegisterPhotosScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _photoUrl = widget.formData['photoUrl'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Photos')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Photo URL'),
                initialValue: _photoUrl,
                onSaved: (value) => _photoUrl = value,
                validator: (value) =>
                    value!.isEmpty ? 'Photo URL is required' : null,
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
                          'photoUrl': _photoUrl,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterSubscriptionScreen(
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
