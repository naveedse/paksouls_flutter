import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPersonalDetails extends StatefulWidget {
  @override
  _RegisterPersonalDetailsState createState() =>
      _RegisterPersonalDetailsState();
}

class _RegisterPersonalDetailsState extends State<RegisterPersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  final _heightFeetController = TextEditingController();
  final _heightInchesController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedGender;
  int? _selectedYear;
  int? _selectedMonth;
  int? _selectedDay;
  String? _selectedMaritalStatus;
  String? _selectedSkin;
  String? _selectedReligion;
  String? _selectedSect;
  String? _selectedCaste;

  List<String> _genders = ['Male', 'Female'];
  List<String> _maritalStatuses = ['Single', 'Divorced', 'Widowed', 'Married'];
  List<String> _skins = ['Fair', 'Medium', 'Dark'];
  List<String> _religions = ['Muslims', 'Hindu', 'Christian', 'Sikh', 'Other'];
  List<String> _sects = [
    'Sunni - Barelvi',
    'Sunni - Deobandi',
    'Sunni - Ahlehadees',
    'Shia',
    'Other'
  ];
  List<String> _castes = [
    'Siddiquie',
    'Yousuf Zai',
    'Sindhi',
    'Punjabi',
    'Baloch',
    'Khan'
  ];

  List<int> _getYears(String gender) {
    final currentYear = DateTime.now().year;

    int startYear;
    int endYear;

    if (gender == 'Male') {
      startYear = currentYear - 25; // 25 years ago
      endYear = currentYear - 65; // 65 years ago
    } else {
      startYear = currentYear - 18; // 18 years ago
      endYear = currentYear - 60; // 60 years ago
    }

    // Generate a list of years from startYear to endYear
    List<int> years =
        List.generate(startYear - endYear + 1, (index) => startYear - index);

    return years;
  }

  List<String> _getMonths() {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
  }

  List<int> _getDays(int? year, int? month) {
    if (month == null || year == null) return [];
    switch (month) {
      case 2: // February
        return List.generate(
            (DateTime(year, month + 1, 0).day), (index) => index + 1);
      case 4:
      case 6:
      case 9:
      case 11:
        return List.generate(30, (index) => index + 1);
      default:
        return List.generate(31, (index) => index + 1);
    }
  }

  @override
  void dispose() {
    _heightFeetController.dispose();
    _heightInchesController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: _genders.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gender',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                    _selectedYear = null;
                    _selectedMonth = null;
                    _selectedDay = null;
                  });
                },
                validator: (value) =>
                    value == null ? 'This field is required' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedYear,
                      items: _getYears(_selectedGender ?? 'Male').map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Year',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value;
                          _selectedMonth = null;
                          _selectedDay = null;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'This field is required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedMonth != null
                          ? _getMonths()[_selectedMonth! - 1]
                          : null,
                      items: _selectedYear != null
                          ? _getMonths().map((month) {
                              return DropdownMenuItem<String>(
                                value: month,
                                child: Text(month),
                              );
                            }).toList()
                          : [],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Month',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = _getMonths().indexOf(value!) + 1;
                          _selectedDay = null; // Reset days when month changes
                        });
                      },
                      validator: (value) =>
                          value == null ? 'This field is required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedDay,
                      items: _getDays(_selectedYear, _selectedMonth).map((day) {
                        return DropdownMenuItem<int>(
                          value: day,
                          child: Text(day.toString()),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Day',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'This field is required' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMaritalStatus,
                items: _maritalStatuses.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Marital Status',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedMaritalStatus = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'This field is required' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _heightFeetController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Height (feet)',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        final feet = double.tryParse(value);
                        if (feet == null || feet < 3 || feet > 10) {
                          return 'Height must be between 3 and 10 feet';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _heightInchesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Inches',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        final inches = double.tryParse(value);
                        if (inches == null || inches < 0 || inches >= 12) {
                          return 'Inches must be between 0 and 12';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weight (kg)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight < 30 || weight > 200) {
                    return 'Weight must be between 30 and 200 kg';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedSkin,
                items: _skins.map((skin) {
                  return DropdownMenuItem<String>(
                    value: skin,
                    child: Text(skin),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Skin Color',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedSkin = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedReligion,
                items: _religions.map((religion) {
                  return DropdownMenuItem<String>(
                    value: religion,
                    child: Text(religion),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Religion',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedReligion = value;
                    _selectedSect = null;
                    _selectedCaste = null;
                  });
                },
                validator: (value) =>
                    value == null ? 'This field is required' : null,
              ),
              SizedBox(height: 16),
              if (_selectedReligion == 'Muslims')
                DropdownButtonFormField<String>(
                  value: _selectedSect,
                  items: _sects.map((sect) {
                    return DropdownMenuItem<String>(
                      value: sect,
                      child: Text(sect),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Sect',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedSect = value;
                    });
                  },
                ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCaste,
                items: _castes.map((caste) {
                  return DropdownMenuItem<String>(
                    value: caste,
                    child: Text(caste),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Caste',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedCaste = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pushNamed(context, '/register_user');
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
