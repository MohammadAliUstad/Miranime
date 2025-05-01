import 'package:flutter/material.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My List'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'You haven\'t added any anime yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}