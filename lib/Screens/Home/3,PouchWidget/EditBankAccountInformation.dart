import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moovlah_driver/Service/Database.dart';
import 'package:moovlah_driver/Shared/YellowButton.dart';

class EditBankAccountInformation extends StatefulWidget {
  const EditBankAccountInformation({super.key});

  @override
  State<EditBankAccountInformation> createState() =>
      _EditBankAccountInformationState();
}

class _EditBankAccountInformationState
    extends State<EditBankAccountInformation> {
  String nameOfBank = '';
  String accountNumber = '';
  String accountHolderName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Edit Account Information',
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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField('Name of Bank', 'NameOfBank'),
              TextField('Account Number', 'AccountNumber'),
              TextField('Account holder name', 'AccountHolderName'),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    final user = FirebaseAuth.instance.currentUser;
                    final userUid = user!.uid;
                    DatabaseService().AddBankInformation(
                        userUid, nameOfBank, accountNumber, accountHolderName);
                    Navigator.of(context).pop();
                  },
                  child: YellowButton(text: 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextField(var label, var value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  if (value == 'NameOfBank') nameOfBank = val;
                  if (value == 'AccountNumber') accountNumber = val;
                  if (value == 'AccountHolderName') accountHolderName = val;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 30, bottom: 10),
                labelText: label,
                focusColor: Colors.orange[900],
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20.0,
                    color: Colors.grey[800]),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.orange.shade200)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
