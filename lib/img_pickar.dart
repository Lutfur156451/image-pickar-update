import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:img_pickar/user_data.dart';
import 'package:img_pickar/user_data_upload.dart';

class img_pickar extends StatefulWidget {
  const img_pickar({Key? key}) : super(key: key);

  @override
  State<img_pickar> createState() => _img_pickarState();
}

class _img_pickarState extends State<img_pickar> {
  XFile? _pickImage1;

  chooseImageFromGallery() async {
    final ImagePicker _pickar = ImagePicker();
    _pickImage1 = await _pickar.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade200),
            height: 400,
            width: 400,
            child: Material(
              child: Center(
                child: _pickImage1 == null
                    ? IconButton(
                        onPressed: () {
                          chooseImageFromGallery();
                          Timer(Duration(seconds: 3), () {
                            Fluttertoast.showToast(
                                msg: "Image Path receive",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                        },
                        icon: Icon(Icons.image),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(_pickImage1!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_pickImage1?.path == null) {
                              Fluttertoast.showToast(
                                  msg: "Image Path is null",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Image Path already receive",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text('Upload'))),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => userDataScreen(),
                                ));
                          },
                          child: Text('Next'))),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
