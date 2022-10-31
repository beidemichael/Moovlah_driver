// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';

class Pouch extends StatefulWidget {
  const Pouch({super.key});

  @override
  State<Pouch> createState() => _PouchState();
}

class _PouchState extends State<Pouch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('My Earnings',
                  style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          excludeHeaderSemantics: true,
          backgroundColor: Colors.grey[50],
          automaticallyImplyLeading: false,
          elevation: 3,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Container(
            // height: 200,
            width: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              color: Colors.grey[350],
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Total Earning',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 100, 100, 100),
                          fontWeight: FontWeight.w600)),
                  const Text('S\$' '15.65',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Deposit Money',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 100, 100, 100),
                          fontWeight: FontWeight.w600)),
                  const Text('S\$' '75.15',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Under Review',
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Color.fromARGB(255, 100, 100, 100),
                          fontWeight: FontWeight.w600)),
                  const Text('S\$' '0.65',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          choices('Top-up', FontAwesomeIcons.moneyBill, 'top'),
          const SizedBox(
            height: 10,
          ),
          choices('Withdrawal', FontAwesomeIcons.anglesRight, 'middle'),
          const SizedBox(
            height: 10,
          ),
          choices('Account Statement', FontAwesomeIcons.receipt, 'middle'),
          const SizedBox(
            height: 10,
          ),
          choices('Bank Account Information', FontAwesomeIcons.buildingColumns,
              'bottom'),
        ],
      ),
    );
  }

  Widget choices(String text, var icon, String type) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      // height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: type == 'top'
            ? const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))
            : type == 'middle'
                ? const BorderRadius.all(Radius.circular(0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  icon,
                  size: 20.0,
                  color: const Color(0xFFFFF600),
                  // ignore: prefer_const_literals_to_create_immutables
                  shadows: [
                    const BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      blurRadius: 2.0, //effect of softening the shadow
                      spreadRadius: 1, //effecet of extending the shadow
                      offset: Offset(
                          0.0, //horizontal
                          0.0 //vertical
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Marquee(
                  backDuration: const Duration(milliseconds: 500),
                  directionMarguee: DirectionMarguee.oneDirection,
                  child: Text(text,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Icon(
              FontAwesomeIcons.angleRight,
              size: 20.0,
              color: const Color.fromARGB(255, 129, 129, 129),
            ),
          ],
        ),
      ),
    );
  }
}
