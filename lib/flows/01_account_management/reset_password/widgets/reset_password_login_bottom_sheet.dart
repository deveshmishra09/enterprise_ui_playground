import 'package:enterprise_ui_playground/flows/01_account_management/reset_password/screens/reset_password_login_screen.dart';
import 'package:enterprise_ui_playground/flows/01_account_management/reset_password/widgets/reset_password_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ResetPasswordLoginBottomSheet extends StatelessWidget {
  const ResetPasswordLoginBottomSheet({super.key});

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
                            'Login',
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
          
                  Row(
                    children: [
                      Text('Login with your On account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    ]
                  ),
          
                  const SizedBox(height: 20),
          
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Password', 
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
          
                  const SizedBox(height: 30),
          
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ResetPasswordLoginScreen(),
                              )
                            );
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                    ],
                  ),
          
                  const SizedBox(height: 20),
          
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const ResetPasswordBottomSheet();
                        },
                      );
                    },
                    child: const Text('Forgot password?', style: TextStyle(decoration: TextDecoration.underline, color: Colors.black)),
                  ),
                  
                  const SizedBox(height: 20),
          
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
          
                  const SizedBox(height: 20),
          
                  Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          // Handle Google login logic here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.g_mobiledata, color: Colors.black, size: 30),
                            const SizedBox(width: 10),
                            const Text('Continue with Google'),
                          ],
                        ),
                      ),
                    ),
                  ],),
          
                  const SizedBox(height: 20),
          
                  Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          // Handle Google login logic here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.apple, color: Colors.black, size: 30),
                            const SizedBox(width: 10),
                            const Text('Continue with Apple'),
                          ],
                        ),
                      ),
                    ),
                  ],)
                ],
              ),
            ),
          ),
        ),
           ),
     );
  }
}
