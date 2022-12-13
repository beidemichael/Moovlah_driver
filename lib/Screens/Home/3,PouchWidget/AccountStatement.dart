import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../../Service/time.dart';
import 'package:ntp/ntp.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  DateTime now = DateTime.now();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    timeNow();
  }

  timeNow() async {
    now = await NTP.now();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accountStatement = Provider.of<List<Payment>>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Account Statement',
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
      body: accountStatement.length == 0
          ? const Text(
              'No Account Statement Yet.',
              style: TextStyle(
                  fontSize: 21.0,
                  color: Color.fromARGB(255, 100, 100, 100),
                  fontWeight: FontWeight.w600),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: accountStatement.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        // height: 20,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    accountStatement[index].type,
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(255, 87, 87, 87),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accountStatement[index].approved ==
                                              false
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.green.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        bottomLeft: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.5),
                                      child: Text(
                                        accountStatement[index].approved ==
                                                false
                                            ? 'Pending'
                                            : 'Approved',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: accountStatement[index]
                                                        .approved ==
                                                    false
                                                ? Colors.red.withOpacity(0.7)
                                                : Colors.green.withOpacity(0.9),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  loading
                                      ? SpinKitCircle(
                                          color: Colors.grey[500],
                                          size: 15.0,
                                        )
                                      : Text(
                                          convertTimeStampp(
                                                  accountStatement[index]
                                                      .created
                                                      .millisecondsSinceEpoch,
                                                  now)
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.w300)),
                                ],
                              ),
                              Text(
                                accountStatement[index].type == 'Withdraw'
                                    ? '-' +
                                        'S\$' +
                                        accountStatement[index]
                                            .amount
                                            .toString()
                                    : '+'
                                            'S\$' +
                                        accountStatement[index]
                                            .amount
                                            .toString(),
                                style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Color.fromARGB(255, 66, 66, 66),
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
