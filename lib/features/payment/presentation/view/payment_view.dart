import 'package:final_assignment/features/payment/domain/entity/payment_entity.dart';
import 'package:final_assignment/features/payment/presentation/viewmodel/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentView extends ConsumerStatefulWidget {
  const PaymentView({super.key, required this.petId});

  final String petId;

  @override
  ConsumerState createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  late TextEditingController amountController;

  @override
  void initState() {
    amountController = TextEditingController(text: '10');
    super.initState();
    Future.microtask(() {
      ref.read(paymentViewModelProvider.notifier).getPet(widget.petId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = ref.watch(paymentViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            paymentState.isLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
            paymentState.error != null
                ? Text(
                    paymentState.error!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink(),
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
              controller: amountController,
            ),
            const SizedBox(height: 20),
            const Text('Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: paymentState.paymentMethod == 'cash'
                          ? Colors.green[500]
                          : Colors.grey[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ref
                          .read(paymentViewModelProvider.notifier)
                          .changePaymentMethod('cash');
                    },
                    child: const Text('cash'),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: paymentState.paymentMethod == 'khalti'
                          ? Colors.green[500]
                          : Colors.grey[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      ref
                          .read(paymentViewModelProvider.notifier)
                          .changePaymentMethod('khalti');
                    },
                    child: const Text('khalti'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                PaymentEntity entity = PaymentEntity(
                  pet: paymentState.petEntity!,
                  paymentAmount: double.parse(amountController.text),
                  paymentMethod: paymentState.paymentMethod,
                );
                ref
                    .read(paymentViewModelProvider.notifier)
                    .createPayment(entity);
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
