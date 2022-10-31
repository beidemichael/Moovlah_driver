// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, FirebaseFirestore, QuerySnapshot, Timestamp;

import '../Models/models.dart';

class DatabaseService {
  // ignore: prefer_typing_uninitialized_variables
  var userUid;

  DatabaseService({this.userUid});

  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('Vehicles');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('Drivers');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');

//1//////////////////User//////////////////////////////////////////////////
//1.1//////////////////Write//////////////////////////////////////////////////

//1.1//////////////////Write//////////////////////////////////////////////////
//1.2//////////////////Edit//////////////////////////////////////////////////

//1.2//////////////////Edit//////////////////////////////////////////////////
//1.3//////////////////Read//////////////////////////////////////////////////

  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        userName: (doc.data() as dynamic)['driverName'] ?? '',
        type: (doc.data() as dynamic)['vehicleType'] ?? false,
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        approved: (doc.data() as dynamic)['approved'] ?? false,
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    return driverCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

//1.3//////////////////Read//////////////////////////////////////////////////
//1///////////////////User//////////////////////////////////////////////////
//2///////////////////Vehicle//////////////////////////////////////////////////
//2.1//////////////////Read//////////////////////////////////////////////////
//Read vehicle list.
  List<Vehicles> _vehiclesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Vehicles(
        type: (doc.data() as dynamic)['Type'] ?? '',
        description: (doc.data() as dynamic)['Description'] ?? '',
        capacity: (doc.data() as dynamic)['Capacity'] ?? '',
        dimension: (doc.data() as dynamic)['Dimension'] ?? '',
        image: (doc.data() as dynamic)['Image'] ?? '',
        extraService: (doc.data() as dynamic)['ExtraService'] ?? [],
        extraServicePrice: (doc.data() as dynamic)['ExtraServicePrice'] ?? [],
        specification: (doc.data() as dynamic)['Specification'] ?? [],
        specificationPrice: (doc.data() as dynamic)['SpecificationPrice'] ?? [],
        price: (doc.data() as dynamic)['Price'] ?? 0.0,
        pricePerKM: (doc.data() as dynamic)['PerKM'] ?? 0.0,
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<Vehicles>> get vehicles {
    return vehiclesCollection
        .orderBy('Order', descending: false)
        .snapshots()
        .handleError((onError) {
      print(onError.toString());
    }).map(_vehiclesListFromSnapshot);
  }

//2.1//////////////////Read//////////////////////////////////////////////////
//2///////////////////Vehicle//////////////////////////////////////////////////
//3///////////////////Order//////////////////////////////////////////////////
//3.1//////////////////Read//////////////////////////////////////////////////
  List<OrdersModel> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OrdersModel(
        vehicleName: (doc.data() as dynamic)['vehicleName'] ?? '',
        vehicelPrice: (doc.data() as dynamic)['vehicelPrice'] ?? 0.0,
        extraServiceName: (doc.data() as dynamic)['extraServiceName'] ?? [],
        extraServicePrice: (doc.data() as dynamic)['extraServicePrice'] ?? [],
        specificationName: (doc.data() as dynamic)['specificationName'] ?? [],
        specificationPrice: (doc.data() as dynamic)['specificationPrice'] ?? [],
        orderRemark: (doc.data() as dynamic)['orderRemark'] ?? '',
        time: (doc.data() as dynamic)['time'] ?? Timestamp.now(),
        ordersModelLocationSub: OrdersModelLocationSub(
          locationListName: (doc.data() as dynamic)['locationListName'] ?? [],
          locationListcontactName:
              (doc.data() as dynamic)['locationListcontactName'] ?? [],
          locationListdescription:
              (doc.data() as dynamic)['locationListdescription'] ?? [],
          locationListfloorAndUnitNumber:
              (doc.data() as dynamic)['locationListfloorAndUnitNumber'] ?? [],
          locationListlocationLat:
              (doc.data() as dynamic)['locationListlocationLat'] ?? [],
          locationListlocationLong:
              (doc.data() as dynamic)['locationListlocationLong'] ?? [],
          specificLocationListlocationLat:
              (doc.data() as dynamic)['specificLocationListlocationLat'] ?? [],
          specificLocationListlocationLong:
              (doc.data() as dynamic)['specificLocationListlocationLong'] ?? [],
          locationListphoneNumber:
              (doc.data() as dynamic)['locationListphoneNumber'] ?? [],
        ),
        totalDistanceInt: (doc.data() as dynamic)['totalDistanceInt'] ?? 0,
        totalDistancePrice:
            (doc.data() as dynamic)['totalDistancePrice'] ?? 0.0,
        totalPrice: (doc.data() as dynamic)['totalPrice'] ?? 0.0,
        favouriteDriverFirst:
            (doc.data() as dynamic)['favouriteDriverFirst'] ?? false,
        isCanceled: (doc.data() as dynamic)['isCanceled'] ?? false,
        isDelivered: (doc.data() as dynamic)['isDelivered'] ?? false,
        isTaken: (doc.data() as dynamic)['isTaken'] ?? false,
        cash: (doc.data() as dynamic)['cash'] ?? false,
        paidBy: (doc.data() as dynamic)['paidBy'] ?? '',
        moreDetailsImage: (doc.data() as dynamic)['moreDetailsImage'] ?? '',
        userName: (doc.data() as dynamic)['userName'] ?? '',
        type: (doc.data() as dynamic)['type'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        userUid: (doc.data() as dynamic)['userUid'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  Stream<List<OrdersModel>> get orders {
    return orderCollection
        .where('userUid', isEqualTo: userUid)
        .orderBy('time', descending: true)
        .snapshots()
        .handleError((onError) {
      print('errore in orders read: $onError');
    }).map(_ordersListFromSnapshot);
  }

//3.1//////////////////Read//////////////////////////////////////////////////
//3.2//////////////////Write//////////////////////////////////////////////////
  Future registerInformation(
    String screen,
    String driverName,
    String vehiclePlateNumber,
    String driverNRICNumber,
    String driverLicenseNumber,
    String vehicleType,
    String driverPhoto,
    String driverNRICPhoto,
    String driverLicensePhoto,
    var phoneNumber,
    var userUid,
  ) async {
    driverCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isEmpty) {
        return await driverCollection
            .doc(userUid)
            .set({
              'created': Timestamp.now(),
              'screen': screen,
              'driverName': driverName,
              'vehiclePlateNumber': vehiclePlateNumber,
              'driverNRICNumber': driverNRICNumber,
              'driverLicenseNumber': driverLicenseNumber,
              'vehicleType': vehicleType,
              'driverPhoto': driverPhoto,
              'driverNRICPhoto': driverNRICPhoto,
              'driverLicensePhoto': driverLicensePhoto,
              'phoneNumber': phoneNumber,
              'userUid': userUid,
              'approved': false
            })
            .then((value) => print("Rgistration Info Added"))
            .catchError((error) => print("Failed to Register: $error"));
      }
    });
  }
//3.2//////////////////Write//////////////////////////////////////////////////
//3///////////////////Order//////////////////////////////////////////////////
}
