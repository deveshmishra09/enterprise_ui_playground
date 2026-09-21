import 'package:flutter/material.dart';

class CopyingDuplicatingHomeScreen extends StatefulWidget {
  const CopyingDuplicatingHomeScreen({super.key});

  @override
  State<CopyingDuplicatingHomeScreen> createState() => _CopyingDuplicatingHomeScreenState();
}

class _CopyingDuplicatingHomeScreenState extends State<CopyingDuplicatingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Copying & Duplicating'),
      ),
      body: const Center(
        child: Text('Copying & Duplicating Home Screen'),
      ),
    );
  }
}