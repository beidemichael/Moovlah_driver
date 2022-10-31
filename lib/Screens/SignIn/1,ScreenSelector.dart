// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:moovlah_driver/Screens/SignIn/2,BecomeADriver.dart';
import 'package:moovlah_driver/Screens/SignIn/3,SubmitPhoto.dart';
import 'package:moovlah_driver/Screens/SignIn/4,PendingScreen.dart';
import 'package:provider/provider.dart';

import '../../Models/registerModel.dart';

class ScreenSelector extends StatefulWidget {
  const ScreenSelector({super.key});

  @override
  State<ScreenSelector> createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<Register>(context).screen;
    return screen == 'BecomeADriver'
        ? BecomeADriver()
        : screen == 'SubmitPhoto'
            ? SubmitPhoto()
            : screen == 'Pending'
                ? const PendingScreen()
                : Container();
  }
}
