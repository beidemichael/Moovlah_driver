// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moovlah_driver/Home/4,Profile.dart';

import 'Home/2,History.dart';
import 'Home/1,Orders.dart';
import 'Home/3,Pouch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List screens = [
    const Orders(),
    const History(),
    const Pouch(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[index],
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                // height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF600),
                  // border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 1.0, //effect of softening the shadow
                      spreadRadius: 0.1, //effecet of extending the shadow
                      offset: const Offset(
                          0.0, //horizontal
                          -2.0 //vertical
                          ),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomIcon(FontAwesomeIcons.anglesDown, 'Orders', 0),
                      bottomIcon(FontAwesomeIcons.clockRotateLeft, 'History', 1),
                      bottomIcon(FontAwesomeIcons.coins, 'Pouch', 2),
                      bottomIcon(FontAwesomeIcons.solidUser, 'Profile', 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomIcon(var icon, String text, int localIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = localIndex;
        });
      },
      child: Container(
        height: 55,
        width: 55,
        color: const Color(0xFFFFF600),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                icon,
                size: 20.0,
                color: localIndex == index
                    ? const Color.fromARGB(255, 49, 49, 49)
                    : const Color(0xFFDED600),
              ),
              Text(text,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: localIndex == index
                          ? const Color.fromARGB(255, 49, 49, 49)
                          : const Color(0xFFDED600),
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
