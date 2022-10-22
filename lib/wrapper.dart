import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '5,HomeScreen.dart';
import 'Models/models.dart';
import 'Service/Database.dart';
import 'SignIn/1,SignInPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuth?>(context);

    return StreamProvider<List<UserInformation>>.value(
        value: DatabaseService(userUid: user?.uid).userInfo,
        initialData: const [],
        child: user == null
            ? SignInPage()
            : StreamProvider<List<Vehicles>>.value(
                value: DatabaseService().vehicles,
                initialData: const [],
                catchError: (_, __) => [],
                child: const HomeScreen()));
  }
}
