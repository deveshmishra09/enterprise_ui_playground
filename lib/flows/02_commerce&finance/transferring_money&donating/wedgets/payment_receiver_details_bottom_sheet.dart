import 'package:enterprise_ui_playground/flows/02_commerce&finance/transferring_money&donating/wedgets/additional_fields_bottom_sheet.dart';
import 'package:enterprise_ui_playground/flows/02_commerce&finance/transferring_money&donating/wedgets/enter_amount_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PaymentReceiverDetailsBottomSheet extends StatefulWidget {
  const PaymentReceiverDetailsBottomSheet({super.key});

  @override
  State<PaymentReceiverDetailsBottomSheet> createState() =>
      _PaymentReceiverDetailsBottomSheetState();
}

final TextEditingController receiverNameController = TextEditingController();
final TextEditingController receiverPhoneNumberController = TextEditingController();

class _PaymentReceiverDetailsBottomSheetState
    extends State<PaymentReceiverDetailsBottomSheet> {
  String? selectedAdditionalField;

  @override
  Widget build(BuildContext context) {
    final targetHeight =
        MediaQuery.of(context).size.height * 0.8; // 80% of screen height

    return Container(
      height: targetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBet,
              children: [
                Spacer(),
                const Text(
                  'Transfer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Spacer(),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(153, 236, 39, 39),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.account_balance_outlined,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'By phone number',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: receiverPhoneNumberController,
                    decoration: InputDecoration(
                      prefixText: '+91 ',
                      filled: true,
                      fillColor: Colors.white,
                      labelText: selectedAdditionalField,
                      hintText: 'Enter phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: receiverNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: selectedAdditionalField ?? 'Benificiary Name',
                // hintText: 'Benificiary Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                selectedAdditionalField == null
                    ? TextButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return const AdditionalFieldsBottomSheet();
                            },
                          );
                          if (result != null) {
                            setState(() {
                              selectedAdditionalField = result;
                            });
                          }
                        },
                        child: const Text('+ Additional Fields'),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: selectedAdditionalField,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) {
                                    return const AdditionalFieldsBottomSheet();
                                  },
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedAdditionalField = result;
                                  });
                                }
                              },
                              child: const Text('+ Additional Fields'),
                            ),
                          ],
                        ),
                      ),
              ],
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return EnterAmountBottomSheet(
                      receiverPhoneNumber: receiverPhoneNumberController.text,
                      receiverName: receiverNameController.text,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
