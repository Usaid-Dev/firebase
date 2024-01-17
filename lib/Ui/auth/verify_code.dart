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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
