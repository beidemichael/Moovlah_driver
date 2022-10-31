// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';

class TooManyTrialsBlurryDialog extends StatelessWidget {
 
  VoidCallback okCallBack;

  TooManyTrialsBlurryDialog( this.okCallBack);
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Error",
                      style: TextStyle(fontSize: 24.0,color: Colors.grey[900],fontWeight: FontWeight.w600),
                    ),
                   
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
                    child: 
                    Text("You've requested verification code too many times, please try again after 24 hours."
                    ,style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.w300),
                    )
                  ),
                ),
                InkWell(
                  onTap: () {
                    okCallBack();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF600),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                    ),
                    child: const Center(
                      child: Text('OK',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
        ));
  }
}
