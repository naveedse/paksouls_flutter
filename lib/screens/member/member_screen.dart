
import 'package:flutter/material.dart';
import '../common/private_header.dart';
import '../common/private_footer.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrivateHeader(sectionName: 'Members'),
      body: Center(
        child: Text('Member Screen'),
      ),
      bottomNavigationBar: PrivateFooter(),
    );
  }
}
