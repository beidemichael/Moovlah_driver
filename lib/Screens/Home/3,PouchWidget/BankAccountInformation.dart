import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/Home/3,PouchWidget/EditBankAccountInformation.dart';
import 'package:provider/provider.dart';

import '../../../Models/models.dart';
import '../../../Service/Database.dart';

class BankAccountInformation extends StatefulWidget {
  const BankAccountInformation({super.key});

  @override
  State<BankAccountInformation> createState() => _BankAccountInformationState();
}

class _BankAccountInformationState extends State<BankAccountInformation> {
  BankInformation bankInformation = BankInformation(
      accountNumber: '',
      bankName: '',
      documentId: '',
      holderName: '',
      userUid: '',
      created: DateTime.now());
  @override
  Widget build(BuildContext context) {
    final bankInfo = Provider.of<List<BankInformation>>(context);
    if (bankInfo != null && bankInfo.length != 0) {
      bankInformation = bankInfo[0];
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Bank Account Information',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name of Bank',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              bankInformation.bankName,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            const Divider(),
            const Text(
              'Account number',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              bankInformation.accountNumber,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            const Divider(),
            const Text(
              'Account holder name',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              bankInformation.holderName,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final user = FirebaseAuth.instance.currentUser;
          final userUid = user!.uid;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamProvider<List<UserInformation>>.value(
                  value: DatabaseService(userUid: userUid).userInfo,
                  initialData: const [],
                  catchError: (_, __) => [],
                  child: const EditBankAccountInformation()),
            ),
          );
        },
        backgroundColor: const Color(0xFFFFF600),
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
