import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_speedv1/Data/data.dart';
import 'package:image_to_speedv1/Screens/history.dart';
import 'package:image_to_speedv1/Screens/result.dart';

import 'intro.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  File? _image;
  String _text = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _recognizeText(_image!);
    }
  }

  Future<void> _clickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _recognizeText(_image!);
    }
  }

  Future<void> _recognizeText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      setState(() {
        _text = recognizedText.text;
      });
      Get.to(
        routeName: routes["result"],
        () => ResultView(
          text: _text,
        ),
        transition: custransition,
        duration: cusDuration,
        curve: cusCurve,
      );
    } catch (e) {
      debugPrint('Error recognizing text: $e');
      setState(() {
        _text = 'Error recognizing text.';
      });
    } finally {
      textRecognizer.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        width: 500.w,
        child: ListView(
          children: [
            SizedBox(
              height: 200.h,
              child: DrawerHeader(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 300.w),
                      child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState?.closeDrawer();
                          },
                          icon: const Icon(Icons.close)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/drawer.png",
                          height: 200.h,
                          width: 200.w,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(fontSize: 15.w),
              ),
              onTap: () {
                Get.to(
                  routeName: routes["history"],
                  () => const history(),
                  transition: custransition,
                  duration: cusDuration,
                  curve: cusCurve,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 15.w),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then(
                      (value) => Get.offAll(
                        routeName: "intro",
                        () => const Intro(),
                        transition: custransition,
                        duration: cusDuration,
                        curve: cusCurve,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Image to Text Recognition App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  Container(
                    color: Colors.grey,
                    width: 250.w,
                    height: 250.h,
                  ),
                  _image == null
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 70.w,
                            vertical: 120.h,
                          ),
                          child: const Text("No Image Selected"),
                        )
                      : Image.file(
                          _image!,
                          width: 250.w,
                          height: 250.h,
                          fit: BoxFit.fill,
                        )
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.blueAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 10.w,
                      ),
                      child: TextButton(
                        onPressed: () {
                          _pickImage();
                        },
                        child: const Text(
                          "Gallery",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.blueAccent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 10.w,
                      ),
                      child: TextButton(
                        onPressed: () {
                          _clickImage();
                        },
                        child: const Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                child: Text(
                  " Developers",
                  style: TextStyle(fontSize: 22.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: const Divider(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120.w),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.5, // Give it a fixed height
                  child: ListView.builder(
                    itemCount: names.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(names.keys.elementAt(index)),
                        subtitle: Text(names.values.elementAt(index)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
