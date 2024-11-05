import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class CallCenterScreen extends StatelessWidget {
final String phoneNumber = "6282314213239";

Future<void> _callNumber() async {
final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
if (await canLaunchUrl(callUri)) {
await launchUrl(callUri);
} else {
print("Tidak bisa membuka panggilan.");
}
}
@override
Widget build(BuildContext context) {
return Scaffold(

appBar: AppBar(
title: const Text("Call Center"),
backgroundColor: Colors.blue,
),
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.asset(
'assets/images/logo_blangkis.png',
width: 80,
height: 80,
),
const SizedBox(height: 10),
Text(
'Nomor Call Center: $phoneNumber',
style: const TextStyle(fontSize: 16, fontWeight:

FontWeight.bold),
),
const SizedBox(height: 20),
ElevatedButton(
onPressed: _callNumber,
child: const Text("Hubungi Call Center"),
style: ElevatedButton.styleFrom(
padding: const EdgeInsets.symmetric(
vertical: 12.0, horizontal: 20.0),
),
),
],
),
),
);
}
}