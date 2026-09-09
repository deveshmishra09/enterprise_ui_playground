import 'package:enterprise_ui_playground/flows/02_commerce&finance/transferring_money&donating/wedgets/payment_receiver_details_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ChoosePaymentTypeBottomSheet extends StatelessWidget {
  const ChoosePaymentTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final targetHeight = MediaQuery.of(context).size.height * 0.4;

    return Container(
      height: targetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 20.0),
                  child: Text(
                    'Choose Payment Type',
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

            Expanded(
              child: ListView(
                children: [
                  _paymentOptions(context, 'Phone Number', Icons.phone),

                  const Divider(),

                  _paymentOptions(context, 'Credit Card', Icons.credit_card),

                  const Divider(),

                  _paymentOptions(context, 'Debit Card', Icons.credit_card),

                  const Divider(),

                  _paymentOptions(
                    context,
                    'PayPal',
                    Icons.account_balance_wallet,
                  ),

                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _paymentOptions(BuildContext context, String title, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      Navigator.pop(context);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return const PaymentReceiverDetailsBottomSheet();
        },
      );
    },
  );
}
