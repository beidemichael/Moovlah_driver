import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/Home/2,HistoryWidget/InProgressCardDetail.dart';
import 'package:moovlah_driver/Service/Database.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import 'InProgressCard.dart';

class InProgress extends StatefulWidget {
  const InProgress({super.key});

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrdersModel>>(context);

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 180,
      width: MediaQuery.of(context).size.width,
      child: orders.length == 0
          ? Center(
              child: Image.asset(
                'assets/undraw_empty_cart_co35.png',
                height: MediaQuery.of(context).size.height * .25,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final user = FirebaseAuth.instance.currentUser;
                    final userUid = user!.uid;
                    if (userUid != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<List<UserInformation>>.value(
                                      value: DatabaseService(userUid: userUid)
                                          .userInfo,
                                      initialData: const [],
                                      child: InProgressCardDetail(
                                          order: orders[index]))));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: Colors.black),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 2.0, //effect of softening the shadow
                            spreadRadius: 0.2, //effecet of extending the shadow
                            offset: const Offset(
                                0.0, //horizontal
                                2.0 //vertical
                                ),
                          ),
                        ],
                        color: Colors.white,
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      child: InProgressCard(order: orders[index]),
                    ),
                  ),
                );
              }),
    );
  }
}
