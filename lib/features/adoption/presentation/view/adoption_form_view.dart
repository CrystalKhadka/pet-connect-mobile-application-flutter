import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdoptionFormView extends ConsumerStatefulWidget {
  const AdoptionFormView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdoptionFormViewState();
}

class _AdoptionFormViewState extends ConsumerState<AdoptionFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Form'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adoption Form',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
