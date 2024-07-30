import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/registration/register_user.dart';

void main() {
  runApp(MaterialApp(
    title: 'PakSouls.com',
    theme: AppTheme.lightTheme,
    home: RegisterUser(),
  ));
}
