import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:final_assignment/features/payment/presentation/view/payment_success.dart';
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
  late AppLinks _appLinks;

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
        if (paymentResult.payload?.status == 'Completed') {
          log('Payment Success');
        } else {
          log('Payment Failed');
        }
      },
      onMessage: (
        khalti, {
        description,
        statusCode,
        event,
        needsPaymentConfirmation,
      }) async {
        log(
          'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
        );
      },
      onReturn: () {
        log('Returned');
      },
    );

    _initializeAppLinks();
  }

  void _initializeAppLinks() async {
    _appLinks = AppLinks();

    // Handle initial link
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleIncomingLink(initialLink);
    }

    // Listen for incoming links
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        log('Received incoming link: $uri');
        _handleIncomingLink(uri);
      }
    });
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.path.contains('payment-success')) {
      log('Payment Success');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentSuccess()),
      );
    } else {
      log('Received unknown link: $uri');
    }
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
                onPressed: () async {
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
