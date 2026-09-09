import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/widgets/circular_avatar.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/widgets/gender_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/edit_profile/widgets/edit_profile_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedGender;
  String selectedProfileImage =
      'lib/flows/01_account_management/edit_profile/assets/images/profile.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Profile'))),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircularAvatar(imageUrl: selectedProfileImage, radius: 80),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () async {
                              final selectedImage = await showModalBottomSheet<String>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return EditProfileBottomSheet();
                                },
                              );

                              if (selectedImage != null) {
                                setState(() {
                                  selectedProfileImage = selectedImage;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Row(children: [Text('Email')]),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'xyz@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),

                const SizedBox(height: 30),

                Row(children: [Text('First Name')]),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Adam',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),

                const SizedBox(height: 30),

                Row(children: [Text('Last Name')]),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Smith',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),

                const SizedBox(height: 30),

                Row(children: [Text('Date of Birth')]),

                TextField(
                  decoration: InputDecoration(
                    hintText: '01/01/1990',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),

                const SizedBox(height: 30),

                Row(children: [Text('Gender')]),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedGender ?? 'Select gender',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        final gender = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return GenderBottomSheet();
                          },
                        );
                        if (gender != null) {
                          setState(() {
                            selectedGender = gender;
                          });
                        }
                      },
                    ),
                  ],
                ),

                Divider(color: Colors.grey[600], thickness: 1),

                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    elevation: 3,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
