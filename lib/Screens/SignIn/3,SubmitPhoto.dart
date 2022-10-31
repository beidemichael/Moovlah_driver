// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_element, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Models/registerModel.dart';
import '../../Shared/YellowButton.dart';

class SubmitPhoto extends StatefulWidget {
  SubmitPhoto({super.key});

  @override
  State<SubmitPhoto> createState() => _SubmitPhotoState();
}

class _SubmitPhotoState extends State<SubmitPhoto> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? imageFile;
  bool photoNotComplete = false;

  Future getImage(String type) async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);

    setState(() {
      imageFile = File(pickedFile!.path);
      Provider.of<Register>(context, listen: false).addPhoto(imageFile!, type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final driverPhoto = Provider.of<Register>(context).driverPhoto;
    final driverNRICPhoto = Provider.of<Register>(context).driverNRICPhoto;
    final driverLicensePhoto =
        Provider.of<Register>(context).driverLicensePhoto;
    final upLoadLoding = Provider.of<Register>(context).upLoadLoding;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/undraw_photos_re_pvh3.png',
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Submit Photo',
                          style: TextStyle(
                              fontSize: 38.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            getImage('driver');
                          },
                          child: photoContainer(driverPhoto, 'Driver Photo')),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            getImage('NRIC');
                          },
                          child: photoContainer(
                              driverNRICPhoto, 'Driver NRIC Photo')),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            getImage('license');
                          },
                          child: photoContainer(
                              driverLicensePhoto, 'Driver License Photo')),
                      const SizedBox(
                        height: 20,
                      ),
                      photoNotComplete
                          ? Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                    'Please provide the necessary Images.',
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
                            if (driverPhoto != null &&
                                driverLicensePhoto != null &&
                                driverNRICPhoto != null) {
                              setState(() {
                                photoNotComplete = false;
                              });
                              Provider.of<Register>(context, listen: false)
                                  .uploadToDatabase();
                            } else {
                              setState(() {
                                photoNotComplete = true;
                              });
                            }
                          },
                          child: upLoadLoding == true
                              ? const SpinKitCircle(
                                  color: Colors.black,
                                  size: 50.0,
                                )
                              : YellowButton(text: 'Submit')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Provider.of<Register>(context, listen: false)
                    .changeScreen('BecomeADriver');
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Color.fromARGB(255, 116, 115, 115),
                      blurRadius: 2.0, //effect of softening the shadow
                      spreadRadius: 0.5, //effecet of extending the shadow
                      offset: Offset(
                          0.0, //horizontal
                          0.0 //vertical
                          ),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(FontAwesomeIcons.arrowLeft,
                      size: 25.0, color: Colors.grey[700]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget photoContainer(var moreDetailsImage, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1.5, color: const Color.fromARGB(255, 214, 214, 214)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                // height: 90,
                width: 90,
                // ignore: sort_child_properties_last
                child: moreDetailsImage != null ||
                        moreDetailsImage == File('/dev/null')
                    ? SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Image.file(
                            moreDetailsImage,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        color: Color.fromARGB(255, 202, 195, 0),
                      ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 252, 249, 157),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 182, 182, 182)),
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
