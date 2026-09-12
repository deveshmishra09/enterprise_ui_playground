import 'package:enterprise_ui_playground/core/navigation/subflow_reset_scope.dart';
import 'package:flutter/material.dart';

class MobileTopUpScreen extends StatefulWidget {
  const MobileTopUpScreen({super.key});

  @override
  State<MobileTopUpScreen> createState() => _MobileTopUpScreenState();
}

class _MobileTopUpScreenState extends State<MobileTopUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: const Color.fromARGB(255, 8, 29, 218),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jio',
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 63,
                    left: 63,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: const Color.fromARGB(255, 35, 5, 225),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Icon(Icons.star, size: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 20),
          
              Text('My mobile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('+91 XXXXX-XXXXX', style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 108, 107, 107))),
          
              const SizedBox(height: 30),
          
              Text('-₹365',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red)),
          
              const SizedBox(height: 30),
          
              Text('From SBI', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Account No. XXXXX-XXXXX', style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 108, 107, 107))),
              Text('Available Balance: ₹ 10,000', style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 108, 107, 107))),
          
              const SizedBox(height: 50),
          
              Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 18, color: Colors.black),
                      const SizedBox(width: 10),
                      Text('Receipt', style: TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
