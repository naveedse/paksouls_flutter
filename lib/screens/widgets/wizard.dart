// lib/widgets/wizard.dart

import 'package:flutter/material.dart';

class RegistrationWizard extends StatelessWidget {
  final int currentStep;

  const RegistrationWizard({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 1; i <= 7; i++)
            _buildStep(i),
        ],
      ),
    );
  }

  Widget _buildStep(int step) {
    bool isActive = step == currentStep;
    bool isPast = step < currentStep;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : (isPast ? Colors.green : Colors.grey[300]),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive || isPast ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (step < 7)
          Container(
            width: 20,
            height: 2,
            color: isPast ? Colors.green : Colors.grey[300],
          ),
      ],
    );
  }
}