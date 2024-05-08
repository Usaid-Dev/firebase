import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase/widgets/round_button.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({super.key});

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {
  final postController = TextEditingController();

  bool loading = false;

  final firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Firestore Data Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: "Write Your Thoughts",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Add",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  firestore.doc(id).set({
                    'title': postController.text.toString(),
                    'id': id
                  }).then((value) {
                    Navigator.pop(context);
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('post added');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
