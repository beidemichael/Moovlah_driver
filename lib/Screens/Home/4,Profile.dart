// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Service/auth.dart';
import '4,Profile/BarChart.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    UserInformation userInformation = userInfo[0];
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text('Profile',
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
              color: Colors.white,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF600),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: userInformation.userPhoto != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                //image
                                width: 149,
                                height: 149,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: userInformation.userPhoto != ''
                                    ? ClipRRect(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: userInformation.userPhoto,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Colors.grey[300]!),
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.newspaper_rounded,
                                          size: 10,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                              ),
                            )
                          : Icon(
                              FontAwesomeIcons.userLarge,
                              shadows: [
                                BoxShadow(
                                  color: Colors.grey.shade900,
                                  blurRadius:
                                      2.0, //effect of softening the shadow
                                  spreadRadius:
                                      1, //effecet of extending the shadow
                                  offset: const Offset(
                                      0.0, //horizontal
                                      1.0 //vertical
                                      ),
                                ),
                              ],
                              size: 80.0,
                              color: Colors.white,
                            )),
                  Text(userInformation.userName,
                      style: const TextStyle(
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
          choices('Help', FontAwesomeIcons.phone, 'top'),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarChartSample3()),
                );
              },
              child: choices(
                  'Earning Insights', FontAwesomeIcons.piggyBank, 'middle')),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                AuthServices.signOut();
              },
              child: choices('Logout', FontAwesomeIcons.piggyBank, 'bottom')),
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
