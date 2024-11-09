import 'package:flutter/material.dart';
import 'package:mwaa1/widget/theme.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E8E3),
      appBar: AppBar(
        title: const Text('Contact Info'),
        backgroundColor: const Color(0xFFE7E8E3),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}