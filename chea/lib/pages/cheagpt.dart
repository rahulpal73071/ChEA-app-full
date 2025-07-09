import 'package:flutter/material.dart';

class ChEAGPT extends StatelessWidget {
  const ChEAGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: Text('ChEAGPT'),
      ),
    ));
  }
}
