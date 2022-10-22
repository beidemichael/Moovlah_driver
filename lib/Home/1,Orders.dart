// ignore_for_file: file_names

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Service/auth.dart';
import '1.1,MessageBox.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                // border: Border.all(width: 1, color: Colors.black),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 3.0, //effect of softening the shadow
                    spreadRadius: 0.5, //effecet of extending the shadow
                    offset: const Offset(
                        0.0, //horizontal
                        2.0 //vertical
                        ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AuthServices.signOut();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF600),
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: Center(
                            child: Text('Online',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessageBox()),
                        );
                      },
                      child: const Icon(
                        FontAwesomeIcons.solidBell,
                        size: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: Text('Orders',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
