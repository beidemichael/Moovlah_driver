import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/Home/4,Profile/CustomBarChart/ArrageByDateLogic.dart';

import '../../../../../Models/models.dart';

class BottomText extends StatelessWidget {
  String item;
  List<List<OrdersModel>> listOfDateLists;
  int index;
  BottomText(
      {super.key,
      required this.item,
      required this.listOfDateLists,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      child: Center(
        child: item == 'Day'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(item == 'Day'
                      ? ArrageByDateLogic()
                          .monTuesWedConversion(
                              listOfDateLists[index].first.time)
                          .toString()
                      : ''),
                  TextWidget(ArrageByDateLogic()
                      .dateConversion(listOfDateLists[index].first.time)
                      .toString()),
                ],
              )
            : TextWidget(item == 'Week'
                ? ArrageByDateLogic()
                    .dateConversion(listOfDateLists[index].first.time)
                    .toString()
                : item == 'Month'
                    ? ArrageByDateLogic()
                        .monthConversion(listOfDateLists[index].first.time)
                        .toString()
                    : ArrageByDateLogic()
                        .yearConversion(listOfDateLists[index].first.time)
                        .toString()),
      ),
    );
  }

  Widget TextWidget(text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
