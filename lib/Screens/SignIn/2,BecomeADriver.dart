// ignore_for_file: file_names, prefer_const_constructors_in_immutables, unused_element, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moovlah_driver/Models/registerModel.dart';
import 'package:provider/provider.dart';

import '../../Models/models.dart';
import '../../Shared/YellowButton.dart';

class BecomeADriver extends StatefulWidget {
  BecomeADriver({super.key});

  @override
  State<BecomeADriver> createState() => _BecomeADriverState();
}

class _BecomeADriverState extends State<BecomeADriver> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String driverName = '';
  String vehiclePlateNumber = '';
  String driverNRICNumber = '';
  String driverLicenseNumber = '';
  String vehicleType = '';
  int selectedVehicle = 10000;
  bool vehicleOpen = false;
  bool vehicleTypeValid = true;

  @override
  Widget build(BuildContext context) {
    final driverNameProvider = Provider.of<Register>(context).driverName;
    final vehiclePlateNumberProvider =
        Provider.of<Register>(context).vehiclePlateNumber;
    final driverNRICNumberProvider =
        Provider.of<Register>(context).driverNRICNumber;
    final driverLicenseNumberProvider =
        Provider.of<Register>(context).driverLicenseNumber;
    final vehicleTypeProvider = Provider.of<Register>(context).vehicleType;
    final vehicles = Provider.of<List<Vehicles>>(context); 

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
                    'assets/undraw_deliveries_2r4y.png',
                    height: MediaQuery.of(context).size.height * .2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Become a driver',
                      style: TextStyle(
                          fontSize: 38.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(driverNameProvider, 'Driver Name', 'driverName'),
                  TextField(vehiclePlateNumberProvider, 'Vehicle Plate Number',
                      'vehiclePlateNumber'),
                  TextField(driverNRICNumberProvider, 'Driver NRIC Number',
                      'driverNRICNumber'),
                  TextField(driverLicenseNumberProvider,
                      'Driver Licence Number', 'driverLicenseNumber'),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        vehicleOpen = !vehicleOpen;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                              width: 1.25,
                              color: const Color.fromARGB(255, 196, 196, 196)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Select Vehicle Type',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 20.0,
                                          color:
                                              Color.fromARGB(255, 66, 66, 66))),
                                  vehicleOpen
                                      ? const Icon(
                                          FontAwesomeIcons.angleUp,
                                          size: 20.0,
                                          color: Color.fromARGB(
                                              255, 143, 143, 143),
                                        )
                                      : const Icon(
                                          FontAwesomeIcons.angleDown,
                                          size: 20.0,
                                          color: Color.fromARGB(
                                              255, 143, 143, 143),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  vehicleOpen
                      ? vehicles.isEmpty
                          ? const SpinKitCircle(
                              color: Colors.black,
                              size: 20.0,
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                  height: 66 * vehicles.length.toDouble(),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: vehicles.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 50),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedVehicle = index;
                                              vehicleType =
                                                  vehicles[index].type;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: vehicleTypeProvider ==
                                                          vehicles[index]
                                                              .type &&
                                                      selectedVehicle == 10000
                                                  ? const Color.fromARGB(
                                                      255, 245, 255, 152)
                                                  : selectedVehicle == index
                                                      ? const Color.fromARGB(
                                                          255, 245, 255, 152)
                                                      : const Color.fromARGB(
                                                          255, 255, 255, 255),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 206, 206, 206)),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                                    vehicles[index].type,
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        color: Color.fromARGB(
                                                            255, 155, 155, 155),
                                                        fontWeight:
                                                            FontWeight.w400))),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238),
                                ),
                              ],
                            )
                      : Container(),
                  !vehicleOpen
                      ? const SizedBox(
                          height: 50,
                        )
                      : Container(),
                  vehicleTypeValid == false && selectedVehicle == 10000
                      ? Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Please select Vehicle type.',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container(),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                          if (vehicleTypeProvider == '') {
                            vehicleTypeValid = false;
                          } else {
                            vehicleTypeValid = true;
                          }
                        });
                        if (vehicleType != '' || vehicleTypeProvider != '') {
                       
                          if (_formKey.currentState!.validate()) {
                            if (driverName == '') {
                              driverName = driverNameProvider;
                            }
                            if (vehiclePlateNumber == '') {
                              vehiclePlateNumber = vehiclePlateNumberProvider;
                            }
                            if (driverNRICNumber == '') {
                              driverNRICNumber = driverNRICNumberProvider;
                            }
                            if (driverLicenseNumber == '') {
                              driverLicenseNumber = driverLicenseNumberProvider;
                            }
                            if (vehicleType == '') {
                              vehicleType = vehicleTypeProvider;
                            }
                            Provider.of<Register>(context, listen: false)
                                .becomeADriverSetVariables(
                                    driverName,
                                    vehiclePlateNumber,
                                    driverNRICNumber,
                                    driverLicenseNumber,
                                    vehicleType);
                            print('DriverName: ' + driverName);
                            Provider.of<Register>(context, listen: false)
                                .changeScreen('SubmitPhoto');
                          }
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
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextField(var inital, var label, var value) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            initialValue: inital,
            onChanged: (val) {
              setState(() {
                if (value == 'driverName') driverName = val;
                if (value == 'vehiclePlateNumber') vehiclePlateNumber = val;
                if (value == 'driverNRICNumber') driverNRICNumber = val;
                if (value == 'driverLicenseNumber') driverLicenseNumber = val;
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
    );
  }
}
