// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  String userName;
  String phoneNumber;
  String type;
  String userUid;
  bool approved;
  String documentId;

  String userPhoto;
  var deposit;
  var totalEarnings;
  String vehiclePlateNumber;
  String vehicleType;
  bool online;

  UserInformation({
    required this.userName,
    required this.type,
    required this.phoneNumber,
    required this.userUid,
    required this.approved,
    required this.documentId,
    required this.userPhoto,
    required this.vehiclePlateNumber,
    required this.vehicleType,
    required this.deposit,
    required this.totalEarnings,
    required this.online
  });
}

class Vehicles {
  String type;
  String documentId;
  String description;
  String capacity;
  String dimension;
  String image;
  List extraService;
  List extraServicePrice;
  List specification;
  List specificationPrice;
  num price;
  num pricePerKM;

  Vehicles({
    required this.documentId,
    required this.type,
    required this.description,
    required this.capacity,
    required this.dimension,
    required this.image,
    required this.extraService,
    required this.extraServicePrice,
    required this.specification,
    required this.specificationPrice,
    required this.price,
    required this.pricePerKM,
  });
}

class LocationList {
  String name;
  // ignore: prefer_typing_uninitialized_variables
  LatLng location;
  LatLng specificLocaion;
  String description;
  String phoneNumber;
  String contactName;
  String floorAndUnitNumber;
  LocationList(
      {required this.name,
      required this.location,
      required this.description,
      required this.contactName,
      required this.floorAndUnitNumber,
      required this.phoneNumber,
      required this.specificLocaion});
}

class OrdersModelLocationSub {
  List locationListName;
  List locationListlocationLat;
  List locationListlocationLong;
  List specificLocationListlocationLat;
  List specificLocationListlocationLong;
  List locationListdescription;
  List locationListphoneNumber;
  List locationListcontactName;
  List locationListfloorAndUnitNumber;
  OrdersModelLocationSub({
    required this.locationListName,
    required this.locationListcontactName,
    required this.locationListdescription,
    required this.locationListfloorAndUnitNumber,
    required this.locationListlocationLat,
    required this.locationListlocationLong,
    required this.specificLocationListlocationLat,
    required this.specificLocationListlocationLong,
    required this.locationListphoneNumber,
  });
}

class OrdersModel {
  String vehicleName;
  double vehicelPrice;
  List extraServiceName;
  List extraServicePrice;
  List specificationName;
  List specificationPrice;
  String orderRemark;
  Timestamp time;
  OrdersModelLocationSub ordersModelLocationSub;
  int totalDistanceInt;
  double totalDistancePrice;
  double totalPrice;
  bool favouriteDriverFirst;
  bool cash;
  String paidBy;
  var moreDetailsImage;
  String userName;
  String type;
  String email;
  String userUid;
  String documentId;
  bool isTaken;
  bool isDelivered;
  bool isCanceled;
  String driverPhoto;
  String vehiclePlateNumber;
  String vehicleType;
  OrdersModel({
    required this.cash,
    required this.email,
    required this.extraServiceName,
    required this.extraServicePrice,
    required this.favouriteDriverFirst,
    required this.moreDetailsImage,
    required this.orderRemark,
    required this.paidBy,
    required this.specificationName,
    required this.specificationPrice,
    required this.time,
    required this.totalDistanceInt,
    required this.totalDistancePrice,
    required this.totalPrice,
    required this.type,
    required this.userName,
    required this.userUid,
    required this.vehicelPrice,
    required this.vehicleName,
    required this.documentId,
    required this.ordersModelLocationSub,
    required this.isCanceled,
    required this.isDelivered,
    required this.isTaken,
    required this.driverPhoto,
    required this.vehiclePlateNumber,
    required this.vehicleType,
  });
}

class Payment {
  dynamic amount;
  bool approved;
  String userUid;
  String type;
  String documentId;
  var created;

  Payment(
      {required this.amount,
      required this.approved,
      required this.type,
      required this.userUid,
      required this.documentId,
      required this.created});
}

class BankInformation {
  String userUid;
  String bankName;
  String accountNumber;
  String holderName;
  String documentId;
   var created;
  BankInformation({
    required this.accountNumber,
    required this.bankName,
    required this.documentId,
    required this.holderName,
    required this.userUid,
    required this.created,
  });
}
