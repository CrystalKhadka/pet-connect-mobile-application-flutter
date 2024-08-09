import 'package:final_assignment/features/payment/presentation/view/khalti_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentView extends ConsumerStatefulWidget {
  const PaymentView({super.key, required this.petId});

  final String petId;

  @override
  ConsumerState createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  int amount = 10;
  String referenceId = "";

  payWithKhaltiInApp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const KhaltiSDKDemo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Adoption Payment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Donation Amount (Rs.)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: amount.toString()),
            ),
            const SizedBox(height: 20),
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: payWithKhaltiInApp,
              child: const Text('Pay with Khalti'),
            ),
          ],
        ),
      ),
    );
  }
}
