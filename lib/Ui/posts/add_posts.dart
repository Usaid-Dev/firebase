import 'package:firebase/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "Write Your Thoughts",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: "Add", onTap: () {})
          ],
        ),
      ),
    );
  }
}
