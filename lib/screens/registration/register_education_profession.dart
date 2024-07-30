import 'package:flutter/material.dart';
import 'register_location.dart';

class RegisterEducationProfessionScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onSave;

  RegisterEducationProfessionScreen({required this.formData, required this.onSave});

  @override
  _RegisterEducationProfessionScreenState createState() => _RegisterEducationProfessionScreenState();
}

class _RegisterEducationProfessionScreenState extends State<RegisterEducationProfessionScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _educationLevel;
  String? _industry;
  String? _occupation;
  String? _employmentDetails;

  @override
  void initState() {
    super.initState();
    _educationLevel = widget.formData['educationLevel'];
    _industry = widget.formData['industry'];
    _occupation = widget.formData['occupation'];
    _employmentDetails = widget.formData['employmentDetails'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Education & Profession')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildEducationLevelField(),
              _buildIndustryField(),
              _buildOccupationField(),
              _buildEmploymentDetailsField(),
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
                          'educationLevel': _educationLevel,
                          'industry': _industry,
                          'occupation': _occupation,
                          'employmentDetails': _employmentDetails,
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterLocationScreen(
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

  Widget _buildEducationLevelField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Education Level'),
      value: _educationLevel,
      items: ['High School', 'Bachelor\'s', 'Master\'s', 'PhD', 'Other']
          .map((level) => DropdownMenuItem(
                value: level,
                child: Text(level),
              ))
          .toList(),
      onChanged: (value) => setState(() => _educationLevel = value),
      validator: (value) => value == null ? 'Education Level is required' : null,
    );
  }

  Widget _buildIndustryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Industry'),
      initialValue: _industry,
      onSaved: (value) => _industry = value,
      validator: (value) => value!.isEmpty ? 'Industry is required' : null,
    );
  }

  Widget _buildOccupationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Occupation'),
      initialValue: _occupation,
      onSaved: (value) => _occupation = value,
      validator: (value) => value!.isEmpty ? 'Occupation is required' : null,
    );
  }

  Widget _buildEmploymentDetailsField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Employment Details'),
      initialValue: _employmentDetails,
      onSaved: (value) => _employmentDetails = value,
      validator: (value) => value!.isEmpty ? 'Employment Details are required' : null,
    );
  }
}
