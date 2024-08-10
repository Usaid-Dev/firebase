import 'dart:io';

import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading = false;

  File? _image;

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  Future getGalleryImage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        print("no image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Upload Image '),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : const Center(
                        child: Icon(Icons.image),
                      ),
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            RoundButton(
              title: 'Upload',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });

                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername/' +
                        DateTime.now().millisecondsSinceEpoch.toString());

                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_image!.absolute);

                Future.value(uploadTask).then(
                  (value) async {
                    var newUrl = await ref.getDownloadURL();

                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    databaseRef.child('1').set(
                      {
                        'id': id,
                        'title': newUrl.toString(),
                      },
                    ).then(
                      (value) {
                        setState(
                          () {
                            loading = false;
                          },
                        );
                        Utils().toastMessage('Uploaded');
                      },
                    ).onError(
                      (error, stackTrace) {
                        setState(
                          () {
                            loading = false;
                          },
                        );
                      },
                    ).onError(
                      (error, stackTrace) {
                        setState(
                          () {
                            loading = false;
                          },
                        );
                        Utils().toastMessage(
                          error.toString(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
