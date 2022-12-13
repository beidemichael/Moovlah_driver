import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moovlah_driver/Models/models.dart';
import 'package:moovlah_driver/Service/PaymentController.dart';
import 'package:moovlah_driver/Shared/YellowButton.dart';

import '../../../Service/Database.dart';

class WithDrawalBottomSheet extends StatefulWidget {
  UserInformation userInformation;
  WithDrawalBottomSheet({super.key, required this.userInformation});

  @override
  State<WithDrawalBottomSheet> createState() => _WithDrawalBottomSheetState();
}

class _WithDrawalBottomSheetState extends State<WithDrawalBottomSheet> {
  int amount = 20;
  bool paymentLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          // bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          // bottomLeft: Radius.circular(40.0),
        ),
      ),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Withdrawal',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  if (amount != 0) {
                    setState(() {
                      amount = amount - 10;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      FontAwesomeIcons.minus,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Text(
                'S\$$amount',
                style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {
                  if (amount < 200) {
                    setState(() {
                      amount = amount + 10;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  paymentLoading = true;
                });
                DatabaseService().WithDraw(
                    amount.toDouble(),
                    widget.userInformation.userName,
                    widget.userInformation.userUid);
                Navigator.of(context).pop();
                
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      duration: const Duration(seconds: 2),
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Request Sent',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      )));
                
              },
              child: paymentLoading == false
                  ? YellowButton(text: 'Withdraw')
                  : const SpinKitCircle(
                      color: Colors.black,
                      size: 40.0,
                    )),
        ],
      ),
    );
  }
}
