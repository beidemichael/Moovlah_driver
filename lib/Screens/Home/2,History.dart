// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/Home/2,HistoryWidget/InProgress.dart';
import 'package:moovlah_driver/Service/Database.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';

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
            StreamProvider<List<OrdersModel>>.value(
              value: DatabaseService().inProgressOrders,
              initialData: const [],
              catchError: (_, __) => [],
              child: const  InProgress(),
            ),
           StreamProvider<List<OrdersModel>>.value(
              value: DatabaseService().concludedOrders,
              initialData: const [],
              catchError: (_, __) => [],
              child: const InProgress(),
            ),
            StreamProvider<List<OrdersModel>>.value(
              value: DatabaseService().droppedOrders,
              initialData: const [],
              catchError: (_, __) => [],
              child: const InProgress(),
            ),
            
           
          ],
        ),
      ),
    );
  }
}
