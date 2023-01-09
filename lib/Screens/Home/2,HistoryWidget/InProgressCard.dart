import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../Models/models.dart';

class InProgressCard extends StatefulWidget {
  OrdersModel order;
  InProgressCard({super.key, required this.order});

  @override
  State<InProgressCard> createState() => _InProgressCardState();
}

class _InProgressCardState extends State<InProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF600),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(width: 1.5, color: Colors.black),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                      DateFormat('E,dd MMM,').add_jm().format(DateTime.parse(
                          widget.order.time.toDate().toString())),
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            border: Border.all(width: 1.5, color: Colors.black),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.order.ordersModelLocationSub
                          .locationListdescription.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            index == 0
                                ? const Positioned(
                                    top: 12,
                                    left: 9,
                                    child: Icon(
                                      FontAwesomeIcons.circleDot,
                                      size: 10.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )
                                : index ==
                                        widget
                                                .order
                                                .ordersModelLocationSub
                                                .locationListdescription
                                                .length -
                                            1
                                    ? const Positioned(
                                        top: 12,
                                        left: 9,
                                        child: Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      )
                                    : const Positioned(
                                        top: 12,
                                        left: 9,
                                        child: Icon(
                                          FontAwesomeIcons.circle,
                                          size: 10.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                    widget.order.ordersModelLocationSub
                                        .locationListdescription[index],
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(widget.order.vehicleName,
                        style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
