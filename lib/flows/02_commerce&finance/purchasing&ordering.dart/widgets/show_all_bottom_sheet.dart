import 'package:enterprise_ui_playground/flows/02_commerce&finance/purchasing&ordering.dart/widgets/mobile_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ShowAllBottomSheet extends StatefulWidget {
  const ShowAllBottomSheet({super.key});

  @override
  State<ShowAllBottomSheet> createState() => _ShowAllBottomSheetState();
}

class _ShowAllBottomSheetState extends State<ShowAllBottomSheet> {
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
                      'Bill Payments',
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
              SearchBar(hintText: 'Provider or Service',),
              const SizedBox(height: 20),
              SizedBox(
                height: 600,
                child: ListView(
                  children: [
                    _billPaymentOptions('Mobile', Icons.phone_android, () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return const MobileBottomSheet();
                        },
                      );
                    }),
                    const Divider(),
                    _billPaymentOptions('Electricity', Icons.bolt, () {
                      // Handle navigation to Electricity bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Water', Icons.water_drop, () {
                      // Handle navigation to Water bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Gas', Icons.local_gas_station, () {
                      // Handle navigation to Gas bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('TV', Icons.tv, () {
                      // Handle navigation to TV bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Internet', Icons.wifi, () {
                      // Handle navigation to Internet bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Toll', Icons.local_convenience_store, () {
                      // Handle navigation to Toll bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Parking', Icons.local_parking, () {
                      // Handle navigation to Parking bill payment screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Catalog', Icons.menu_book, () {
                      // Handle navigation to Catalog screen
                    }),
                    const Divider(),
                    _billPaymentOptions('Government', Icons.account_balance, () {
                      // Handle navigation to Government screen
                    }),
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

Widget _billPaymentOptions(String title, IconData icon, VoidCallback? onClick) {
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
        onPressed: onClick ?? () {
          // Handle navigation to the specific bill payment screen
        }
      ),
    ],
  );
}