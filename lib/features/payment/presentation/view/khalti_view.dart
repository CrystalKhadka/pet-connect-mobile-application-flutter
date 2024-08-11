import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class KhaltiView extends ConsumerStatefulWidget {
  const KhaltiView({super.key, required this.pidx});

  final String pidx;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KhaltiViewState();
}

class _KhaltiViewState extends ConsumerState<KhaltiView> {
  late final Future<Khalti> khalti;

  @override
  void initState() {
    super.initState();

    final payConfig = KhaltiPayConfig(
      publicKey: '66aa33728e7d4eeab705f9b8922defc6',
      pidx: widget.pidx,
      environment: Environment.test,
    );

    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,
      onPaymentResult: (paymentResult, khalti) {
        log(paymentResult.toString());
        // Handle the payment result here
        _handlePaymentResult(paymentResult.payload!);

        // Close the Khalti checkout dialog
        khalti.close(context);
      },
      onMessage: (
        khalti, {
        description,
        statusCode,
        event,
        needsPaymentConfirmation,
      }) async {
        // Handle messages if necessary
        log('Message: $description');
        khalti.close(context);
      },
      onReturn: () {
        log('User returned to app without completing payment.');
        Navigator.of(context).pop();
      },
    );
  }

  void _handlePaymentResult(PaymentPayload paymentResult) {
    // Implement your logic to handle the payment result
    // For example, show a dialog or navigate to a result page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(paymentResult.status == 'Completed'
            ? 'Payment Successful'
            : 'Payment Failed'),
        content: Text(paymentResult.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Khalti Payment'),
      ),
      body: Center(
        child: FutureBuilder<Khalti>(
          future: khalti,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ElevatedButton(
                onPressed: () {
                  final khalti = snapshot.data!;
                  khalti.open(context);
                },
                child: const Text('Pay with Khalti'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
