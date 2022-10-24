import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(title),
          const SizedBox(height: 30),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ]),
      ),
    );
  }
}
