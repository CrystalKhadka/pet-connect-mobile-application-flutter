import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        child: Column(
          children: [
            Image.asset(
              'assets/images/pet.jpg',
              fit: BoxFit.cover,
              height: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Pet Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Pet Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Pet Age',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
