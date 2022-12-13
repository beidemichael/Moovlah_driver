import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moovlah_driver/Service/Database.dart';
import 'package:moovlah_driver/Shared/YellowButton.dart';
import 'package:provider/provider.dart';
import '../../../Models/models.dart';

class InProgressCardDetail extends StatefulWidget {
  OrdersModel order;
  InProgressCardDetail({super.key, required this.order});

  @override
  State<InProgressCardDetail> createState() => _InProgressCardDetailState();
}

class _InProgressCardDetailState extends State<InProgressCardDetail> {
  var userInfo;
  @override
  Widget build(BuildContext context) {
    final userInformation = Provider.of<List<UserInformation>>(context);

    if (userInformation != null && userInformation.length != 0) {
      userInfo = UserInformation(
          deposit: userInformation[0].deposit,
          totalEarnings: userInformation[0].totalEarnings,
          userName: userInformation[0].userName,
          type: userInformation[0].type,
          phoneNumber: userInformation[0].phoneNumber,
          userUid: userInformation[0].userUid,
          approved: userInformation[0].approved,
          documentId: userInformation[0].documentId,
          userPhoto: userInformation[0].userPhoto,
          vehiclePlateNumber: userInformation[0].vehiclePlateNumber,
          vehicleType: userInformation[0].vehicleType);
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: const Color(0xFFFFF600),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              DateFormat('E,').add_jm().format(DateTime.parse(
                                  widget.order.time.toDate().toString())),
                              style: const TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          border: Border.all(width: 1.5, color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.order.totalDistanceInt.toString() +
                                      ' KM',
                                  style: const TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: widget
                                          .order
                                          .ordersModelLocationSub
                                          .locationListdescription
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            index == 0
                                                ? const Positioned(
                                                    top: 12,
                                                    left: 9,
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .circleDot,
                                                      size: 10.0,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
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
                                                          FontAwesomeIcons
                                                              .locationDot,
                                                          size: 12.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      )
                                                    : const Positioned(
                                                        top: 12,
                                                        left: 9,
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .circle,
                                                          size: 10.0,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                    widget
                                                            .order
                                                            .ordersModelLocationSub
                                                            .locationListdescription[
                                                        index],
                                                    style: const TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              const Divider(),
                              // ignore: prefer_const_constructors
                              Center(
                                // ignore: prefer_const_constructors
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: const Text('Invoice Breakup',
                                      style: TextStyle(
                                          fontSize: 21.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Text('Paid by ',
                                            style: TextStyle(
                                                fontSize: 21.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                        Text(
                                            widget.order.cash == true
                                                ? 'cash'
                                                : 'credit',
                                            style: const TextStyle(
                                                fontSize: 21.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      'S\$' +
                                          widget.order.totalPrice.toString(),
                                      style: const TextStyle(
                                          fontSize: 21.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Base Price',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 146, 146, 146),
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'S\$' +
                                          widget.order.vehicelPrice.toString(),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 146, 146, 146),
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Extra Mileage Fee',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 146, 146, 146),
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'S\$' +
                                          widget.order.totalDistancePrice
                                              .toString(),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 146, 146, 146),
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Total Fare',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'S\$' +
                                            widget.order.totalPrice.toString(),
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(widget.order.vehicleName,
                                    style: const TextStyle(
                                        fontSize: 23.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                // height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.envelopeOpenText,
                                            size: 25.0,
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(widget.order.orderRemark,
                                            maxLines: 100,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 158, 158, 158),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        DatabaseService().OrderTaken(
                            userInfo.userUid,
                            userInfo.userName,
                            userInfo.userPhoto,
                            userInfo.phoneNumber,
                            userInfo.vehiclePlateNumber,
                            userInfo.vehicleType,
                            widget.order.documentId);
                        Navigator.of(context).pop();
                      },
                      child: Stack(
                        children: [
                          Center(child: YellowButton(text: 'Take Order')),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            right: MediaQuery.of(context).size.width * 0.25,
                            child: const Icon(
                              FontAwesomeIcons.anglesRight,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: MediaQuery.of(context).size.width * 0.25,
                            child: const Icon(
                              FontAwesomeIcons.anglesRight,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
