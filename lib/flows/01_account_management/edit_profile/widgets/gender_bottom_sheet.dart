import 'package:flutter/material.dart';

class GenderBottomSheet extends StatefulWidget {
  const GenderBottomSheet({super.key});

  @override
  State<GenderBottomSheet> createState() => _GenderBottomSheetState();
}

class _GenderBottomSheetState extends State<GenderBottomSheet> {
  String? groupValue;

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight = MediaQuery.sizeOf(context).height * 0.8;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxSheetHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            'Select your gender',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Column(
                    children: [
                      RadioMenuButton<String>(
                        value: 'Male',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() => groupValue = value);
                          Navigator.pop(context, 'Male');
                        },
                        child: const Text('Male'),
                      ),
                      Divider(color: Colors.grey),
                      RadioMenuButton<String>(
                        value: 'Female',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() => groupValue = value);
                          Navigator.pop(context, 'Female');
                        },
                        child: const Text('Female'),
                      ),
                      Divider(color: Colors.grey),
                      RadioMenuButton<String>(
                        value: 'Other',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() => groupValue = value);
                          Navigator.pop(context, 'Other');
                        },
                        child: const Text('Other'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
