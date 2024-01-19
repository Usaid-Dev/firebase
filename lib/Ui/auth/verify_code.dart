import 'package:firebase/Ui/posts/post_screen.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;

  final verificationCodeController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Verify',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '6 digit code'),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Verify',
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final crendital = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: verificationCodeController.text.toString(),
                );
                try {
                  await auth.signInWithCredential(crendital);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostScreen(),
                    ),
                  );
                } catch (e) {
                  setState(() {
                    loading = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
