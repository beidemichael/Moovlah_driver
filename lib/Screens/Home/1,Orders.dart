// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Service/Database.dart';
import '../../Service/auth.dart';
import '1.1,MessageBox.dart';
import '1,OrdersWidget/OrdersCardDetail.dart';
import '1,OrdersWidget/OrdesCard.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrdersModel>>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                // border: Border.all(width: 1, color: Colors.black),

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AuthServices.signOut();
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF600),
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: Center(
                            child: Text('Online',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MessageBox()),
                        );
                      },
                      child: const Icon(
                        FontAwesomeIcons.solidBell,
                        size: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - 180,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
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
                                  builder: (context) => StreamProvider<
                                          List<UserInformation>>.value(
                                      value: DatabaseService(userUid: userUid)
                                          .userInfo,
                                      initialData: const [],
                                      child: OrdersCardDetail(
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
                                blurRadius:
                                    2.0, //effect of softening the shadow
                                spreadRadius:
                                    0.2, //effecet of extending the shadow
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
                          child: OrdersCard(order: orders[index]),
                        ),
                      ),
                    );
                  }),
            ),
            // ignore: prefer_const_constructors
            Container(
              color: Colors.white,
              height: 500,
            )
          ],
        ),
      ),
    );
  }
}
