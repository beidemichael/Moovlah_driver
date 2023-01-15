import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moovlah_driver/Screens/Home/4,Profile/CustomBarChart/ArrageByDateLogic.dart';
import 'package:moovlah_driver/Screens/Home/4,Profile/CustomBarChart/CustomBarChartWidgets/BottomText.dart';
import 'package:moovlah_driver/Screens/Home/4,Profile/CustomBarChart/CustomBarChart.dart';
import 'package:moovlah_driver/Screens/Home/4,Profile/IncomeStat.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../Models/models.dart';

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  int max = 0;
  String item = 'Day';
  var items = [
    'Day',
    'Week',
    'Month',
    'Year',
  ];
  List<List<OrdersModel>> listOfDateLists = [];

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrdersModel>>(context);
    List<List<OrdersModel>> listOfDateLists =
        ArrageByDateLogic().calculation(orders, item);
    max = ArrageByDateLogic().maxNumber();
    print(FirebaseAuth.instance.currentUser?.uid);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Earnings Insights',
                style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          excludeHeaderSemantics: true,
          backgroundColor: Colors.grey[50],
          // automaticallyImplyLeading: false,
          elevation: 3,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(width: 1, color: Color(0xFFC5C5C5)),
                  ),
                  child: ToggleSwitch(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 60.0,
                    fontSize: 16.0,
                    initialLabelIndex: items.indexOf(item),
                    activeBgColor: const [
                      Color.fromARGB(255, 71, 69, 0),
                      Color.fromARGB(255, 49, 49, 49),
                      Color.fromARGB(255, 71, 69, 0)
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: const Color(0xFFFFF600),
                    inactiveFgColor: Colors.grey[900],
                    totalSwitches: 4,
                    labels: const [
                      'Day',
                      'Week',
                      'Month',
                      'Year',
                    ],
                    onToggle: (index) {
                      setState(() {
                        item = items[index!];
                        max = 0;
                      });

                      print('switched to: $index');
                    },
                  ),
                ),
              ),
              orders == null
                  ? const Center(
                      child: SpinKitCircle(
                        color: Colors.black,
                        size: 50.0,
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          child: orders.isEmpty
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                        'You don\'t have any orders yet.',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )
                              : Center(
                                  child: CustomBarChart(
                                    listOfDateLists: listOfDateLists,
                                    item: item,
                                  ),
                                ),
                        ),
                        IncomeStat(completeOrders: orders)
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
