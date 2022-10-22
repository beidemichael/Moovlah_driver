import 'package:flutter/material.dart';

import '5,HomeScreen.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/Untitled.png',
              width: MediaQuery.of(context).size.width * .6,
            ),
          ),
          const Text('Thankyou for submitting',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 156, 156, 156),
                  fontWeight: FontWeight.w400)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text('Pending for Approval...',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 133, 133, 133),
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
