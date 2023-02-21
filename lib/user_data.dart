import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:img_pickar/custom_button.dart';
import 'package:img_pickar/custom_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class user extends StatefulWidget {
  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  TextEditingController _usercontroller = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _decController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No Image');
    }
  }

  Future uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse('http://datanapp.com/desh/upload.php');
    var request = new http.MultipartRequest(
      'Post',
      uri,
    );

    request.fields['file'] = image!.path;
    request.fields['user'] = _usercontroller.text;
    request.fields['title'] = _usercontroller.text;
    request.fields['description'] = _usercontroller.text;
    request.fields['city'] = _usercontroller.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.request!.url);


      Fluttertoast.showToast(
          msg: "Data upload successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      //Get.toNamed(navbar);


      setState(() {
        showSpinner = false;
      });

      print('Image Uploaded done');
    } else {
      setState(() {
        showSpinner = true;
      });
      Fluttertoast.showToast(
          msg: "Data upload failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
          )),
      blur: 0.1,
      color: Colors.black.withOpacity(0.8),
      inAsyncCall: showSpinner,
      child: Scaffold(
        //backgroundColor: //Appcolor.backgroundcolor,
        body: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),

                    Text(
                      'Tell Us More About You.',
                      style: TextStyle(
                        fontSize: 33.sp,
                        fontWeight: FontWeight.w700,
                        //color: Appcolor.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'Submit your data',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300,
                       // color: Appcolor.secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    customFormField(
                      hintText: 'User name',
                      inputtype: TextInputType.name,
                      controlller: _usercontroller,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-z]+$').hasMatch(value!)) {
                          return "Can't be correct";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    customFormField(
                      hintText: 'Enter Title',
                      inputtype: TextInputType.name,
                      controlller: _titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't be correct";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customFormField(
                      hintText: 'City',
                      inputtype: TextInputType.name,
                      controlller: _cityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't be correct";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customFormField(
                      hintText: 'Description',
                      inputtype: TextInputType.name,
                      controlller: _decController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't be correct";
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width,

                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5)),

                          child: image == null
                              ? Center(
                            child: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: Icon(
                                Icons.image,
                              ),
                            ),
                          )
                              : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Image.file(
                                  File(image!.path).absolute,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        )),
                    SizedBox(
                      height: 25,
                    ),

                    coustombuttom('Submit', () {
                      if (_formKey.currentState!.validate()) {
                        uploadImage();



                      }
                    }),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
