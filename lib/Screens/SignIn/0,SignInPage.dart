// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_function_declarations_over_variables, avoid_print

import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moovlah_driver/Screens/SignIn/SignInWidgets/error_signingin.dart';
import 'package:moovlah_driver/Screens/SignIn/SignInWidgets/too_many_times.dart';

import '../../Service/auth.dart';
import '../../Shared/YellowButton.dart';
import 'SignInWidgets/expired_code_blury_dialog.dart';
import 'SignInWidgets/phonenumber_dialog.dart';

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
  String wholePhoneNumber = "";
  String otpCode = "";
  String loginState = "";
  bool otpVisible = false;
  bool resendVisible = false;

  Timer? _timer;
  int _start = 59;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (mounted) {
        setState(
          () {
            if (_start == 2) {
              _showExpiredDialog(context);
              otpVisible = false;
            }
            if (_start == 1) {}
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        );
      }
    });
  }

  _showExpiredDialog(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
        };
    BlurryDialog alert = BlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showErrorDialog(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
        };
    ErrorSigningInBlurryDialog alert = ErrorSigningInBlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _tooManyTimesTried(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
          _timer!.cancel(),
          if (mounted)
            {
              setState(() {
                otpVisible = false;
              }),
            }
        };
    TooManyTrialsBlurryDialog alert = TooManyTrialsBlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showPhoneDialog(BuildContext context) {
    VoidCallback toManyTimes = () => {
          _tooManyTimesTried(context),
        };
    VoidCallback yesCallBack = () => {
          // Navigator.of(context).pop(),
          AuthServices(wholePhoneNumber: wholePhoneNumber)
              .submitPhoneNumber(toManyTimes),
          startTimer(),
          print('submit'),
          setState(() {
            otpVisible = true;
            _start = 59;
          }),
        };
    VoidCallback noCallBack = () => {
          Navigator.of(context).pop(),
        };
    PhoneBlurryDialog alert =
        PhoneBlurryDialog(wholePhoneNumber, yesCallBack, noCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: $countryCode");
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
                  Visibility(
                    visible: !otpVisible,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          'You’ll receive 6 digit code for phone number verification',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Visibility(
                    visible: otpVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          'Please enter the activation code we have sent via SMS to:  ' +
                              wholePhoneNumber,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: otpVisible,
                          child: _start >= 10
                              ? Text(
                                  "$_start",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      color: Colors.grey[500]),
                                )
                              : Text(
                                  "$_start",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      color: Colors.grey[500]),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: !otpVisible,
                    child: Padding(
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
                                favorite: const ['+65', 'SG'],
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
                                    phoneNumber = val.trim();
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
                  ),
                  Visibility(
                    visible: otpVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        validator: (val) => val!.length != 6
                            ? 'Code should be 6 digits long'
                            : null,
                        textAlign: TextAlign.center,
                        onChanged: (val) {
                          setState(() {
                            otpCode = val;
                          });
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500

                            // decorationColor: Colors.white,
                            ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 20),

                          //Label Text/////////////////////////////////////////////////////////
                          hintText: '_  _  _  _  _  _',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300

                              // decorationColor: Colors.white,
                              ),
                          // labelText: Texts.PHONE_NUMBER_LOGIN,
                          focusColor: Colors.orange[900],

                          /* hintStyle: TextStyle(
                                      color: Colors.orange[900]
                                      ) */
                          ///////////////////////////////////////////////

                          //when it's not selected////////////////////////////
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                          ////////////////////////////////

                          ///when textfield is selected//////////////////////////
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                color: Color(0xFFFFF600),
                              )),

                          ////////////////////////////////////////
                          ///
                          ///
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 83, 80))),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 83, 80))),
                        ),
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
                        if (_formKey.currentState!.validate()) {
                          if (otpVisible) {
                            VoidCallback codeInvalid =
                                () => {_showErrorDialog(context)};
                            VoidCallback cancelTimer = () => {_timer!.cancel()};
                            AuthServices(otpCode: otpCode).submitOTP(otpCode,
                                wholePhoneNumber, codeInvalid, cancelTimer);
                            print('otp');
                          }
                          if (!otpVisible) {
                            wholePhoneNumber = " ";
                            wholePhoneNumber = phoneCode + phoneNumber.trim();
                            _showPhoneDialog(context);
                          }
                        }
                      },
                      child: isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.black,
                              size: 50.0,
                            ))
                          : YellowButton(
                              text: !otpVisible ? 'Submit' : 'Login')),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
