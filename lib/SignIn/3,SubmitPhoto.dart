// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_element, deprecated_member_use

import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../Shared/YellowButton.dart';
import '4,PendingScreen.dart';

class SubmitPhoto extends StatefulWidget {
  SubmitPhoto({super.key});

  @override
  State<SubmitPhoto> createState() => _SubmitPhotoState();
}

class _SubmitPhotoState extends State<SubmitPhoto> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  String phoneCode = "+65";
  String phoneNumber = "";
  File? imageFile;
  String newImage = '';
  var image;
  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });
  }

  Future getImage() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);

    setState(() {
      imageFile = File(pickedFile!.path);
      // Provider.of<Order>(context, listen: false)
      //     .addMoreDetailsImage(imageFile!);
    });
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
                        getImage();
                      },
                      child: photoContainer(image, 'Driver Photo')),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: photoContainer(image, 'Driver NRIC Photo')),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: photoContainer(image, 'Driver License Photo')),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PendingScreen()),
                        );

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
                          : YellowButton(text: 'Submit')),
                ],
              ),
            ),
          ],
        ),
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
