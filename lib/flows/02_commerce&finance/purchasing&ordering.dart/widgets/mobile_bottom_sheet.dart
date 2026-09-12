import 'package:enterprise_ui_playground/flows/02_commerce&finance/purchasing&ordering.dart/widgets/recharge_bottom_sheet.dart';
import 'package:flutter/material.dart';

class MobileBottomSheet extends StatefulWidget {
  const MobileBottomSheet({super.key});

  @override
  State<MobileBottomSheet> createState() => _MobileBottomSheetState();
}

class _MobileBottomSheetState extends State<MobileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final targetHeight = MediaQuery.of(context).size.height*0.8;
    return Container(
      height: targetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                    child: const Text(
                      'Mobile',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, top: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 600,
                child: ListView(
                  children: [
                    _billPaymentOptions(context, 'Reliance', Icons.sim_card),
                    const Divider(),
                    _billPaymentOptions(context, 'Jio', Icons.sim_card),
                    const Divider(),
                    _billPaymentOptions(context, 'VI', Icons.sim_card),
                    const Divider(),
                    _billPaymentOptions(context, 'Airtel', Icons.sim_card),
                    const Divider(),
                    _billPaymentOptions(context, 'BSNL', Icons.sim_card),
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _billPaymentOptions(BuildContext context, String title, IconData icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 214, 240),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, size: 30),
      ),
      const SizedBox(width: 15),
      Text(title),
      const Spacer(),
      IconButton(
        icon: const Icon(Icons.arrow_forward_ios),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const RechargeBottomSheet();
            },
          );
        }
      )
    ],
  );
}