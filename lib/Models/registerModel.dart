// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../Service/Database.dart';

class Register extends ChangeNotifier {
  String screen = 'BecomeADriver';
  String driverName = '';
  String vehiclePlateNumber = '';
  String driverNRICNumber = '';
  String driverLicenseNumber = '';
  String vehicleType = '';
  var driverPhoto;
  var driverNRICPhoto;
  var driverLicensePhoto;
  String driverPhotoString = '';
  String driverNRICPhotoString = '';
  String driverLicensePhotoString = '';
  bool upLoadLoding = false;

  void changeScreen(String screenFunction) {
    screen = screenFunction;
    notifyListeners();
  }

  void addPhoto(var photo, String type) {
    if (type == 'driver') {
      driverPhoto = photo;
    } else if (type == 'NRIC') {
      driverNRICPhoto = photo;
    } else if (type == 'license') {
      driverLicensePhoto = photo;
    } else {}

    notifyListeners();
  }

  void becomeADriverSetVariables(
      String driverNameFunction,
      String vehiclePlateNumberFunction,
      String driverNRICNumberFunction,
      String driverLicenseNumberFunction,
      String vehicleTypeFunction) {
    driverName = driverNameFunction;
    vehiclePlateNumber = vehiclePlateNumberFunction;
    driverNRICNumber = driverNRICNumberFunction;
    driverLicenseNumber = driverLicenseNumberFunction;
    vehicleType = vehicleTypeFunction;
    notifyListeners();
  }

  Future<void> uploadToDatabase() async {
    upLoadLoding = true;
    notifyListeners();
    if (driverPhoto != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("Driver/DriverPhoto/DriverPhoto${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(driverPhoto!);

      await uploadTask.then((res) async {
        final String downloadUrl = await res.ref.getDownloadURL();

        driverPhotoString = downloadUrl;
      });
    }
    if (driverNRICPhoto != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("Driver/NRIC/driverNRICPhoto${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(driverNRICPhoto!);

      await uploadTask.then((res) async {
        final String downloadUrl = await res.ref.getDownloadURL();

        driverNRICPhotoString = downloadUrl;
      });
    }
    if (driverLicensePhoto != null) {
      FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage
          .ref()
          .child("Driver/License/DriverPhoto${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(driverLicensePhoto!);

      await uploadTask.then((res) async {
        final String downloadUrl = await res.ref.getDownloadURL();

        driverLicensePhotoString = downloadUrl;
      });
    }
    final user = FirebaseAuth.instance.currentUser;
    final phoneNumber = user!.phoneNumber;
    final userUid = user.uid;
    DatabaseService().registerInformation(
      screen,
      driverName,
      vehiclePlateNumber,
      driverNRICNumber,
      driverLicenseNumber,
      vehicleType,
      driverPhotoString,
      driverNRICPhotoString,
      driverLicensePhotoString,
      phoneNumber,
      userUid,
    );
    upLoadLoding = false;
    screen = 'Pending';
    notifyListeners();
  }
}
