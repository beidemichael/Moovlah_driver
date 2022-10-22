// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Shared/YellowButton.dart';
import '2,BecomeADriver.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  String phoneCode = "+65";
  String phoneNumber = "";
  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/undraw_delivery_address_re_cjca.png',
                    height: MediaQuery.of(context).size.height * .3,
                  ),
                  const Text('Enter Your Phone',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: const Text(
                        'You’ll receive 6 digit code for phone number verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 50),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: _onCountryChange,
                              initialSelection: '+65',
                              favorite: ['+65', 'SG'],
                              textStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  phoneNumber = phoneCode + val.trim();
                                  // widget.location.phoneNumber =
                                  //     phoneCode + phoneNumber.trim();
                                });
                              },
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Phonenumber',
                                focusColor: Colors.orange[900],
                                labelStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BecomeADriver()),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.black,
                              size: 50.0,
                            ))
                          : YellowButton(text: 'Continue')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
