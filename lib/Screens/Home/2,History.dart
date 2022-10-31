// ignore_for_file: file_names

import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    const upperTab = TabBar(
        indicatorColor: Color.fromARGB(255, 235, 227, 0),
        indicatorWeight: 6,
        // indicator: BoxDecoration(
        //   color: Color.fromARGB(255, 255, 250, 119),
        //   borderRadius: BorderRadius.all(
        //     const Radius.circular(55.0),
        //   ),
        // ),
        tabs: <Tab>[
          Tab(
            child: Text('InProgress',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Tab(
            child: Text('Concluded',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Tab(
            child: Text('Dropped',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ]);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: true,
            backgroundColor: Colors.grey[50],
            elevation: 3,
            bottom: upperTab,
            iconTheme: const IconThemeData(color: Colors.black)),
        body: TabBarView(
          children: [
            Center(
              child: Image.asset(
                'assets/undraw_empty_cart_co35.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/undraw_empty_cart_co35.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/undraw_empty_cart_co35.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
