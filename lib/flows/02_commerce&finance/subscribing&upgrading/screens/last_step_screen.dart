import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/widgets/credit_cart_painter.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/subscribing&upgrading/widgets/show_google_play_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LastStepScreen extends StatefulWidget {
  const LastStepScreen({super.key});

  @override
  State<LastStepScreen> createState() => _LastStepScreenState();
}

class _LastStepScreenState extends State<LastStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Enterprise UI Playground',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width:
                  100, // Scales everything proportionally based on this width
              height:
                  65, // Ideal aspect ratio for standard cards layout is ~1.5:1
              child: const CustomPaint(
                painter: CreditCardsPainter(
                  color: Color(
                    0xFF1E40AF,
                  ), // Change to fit your app's custom palette
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "One last step!\nAdd a payment method.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "You're all set! Start exploring and enjoy your favorite shows and movies.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 60 + MediaQuery.paddingOf(context).bottom,
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003BFB), Color(0xFF0056FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => showGooglePlayBottomSheet(context),
                  style: OutlinedButton.styleFrom(
                    // backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                  ),
                  child: const Text(
                    'Subscribe',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
