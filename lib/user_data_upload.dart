import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:img_pickar/custom_button.dart';
import 'package:img_pickar/custom_field.dart';
import 'package:img_pickar/home.dart';
import 'package:img_pickar/img_pickar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class userDataScreen extends StatefulWidget {
  const userDataScreen({Key? key}) : super(key: key);

  @override
  State<userDataScreen> createState() => _userDataScreenState();
}

class _userDataScreenState extends State<userDataScreen> {



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
     Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen(),));


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
    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _height/5),
                TextField(
                  controller: _usercontroller,
                  decoration: InputDecoration(
                     hintText: 'user'
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: 'Title'
                  ),
                ),
                TextField(
                  controller: _decController,
                  decoration: InputDecoration(
                      hintText: 'Decription'
                  ),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                      hintText: 'City'
                  ),
                ),
                SizedBox(height: 20,),
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

                SizedBox(height: 20,),

                Container(
                  width: _width,
                  child: ElevatedButton(onPressed: (){
                    uploadImage();

                  }, child: Text('Submit')),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
