import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'update.dart';
import 'login.dart';
import 'call_center.dart';
import 'sms_center.dart';
class DashboardScreen extends StatefulWidget {
const DashboardScreen({super.key});
@override
_DashboardScreenState createState() =>
_DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
final List<Map<String, dynamic>> _products = [
{
'name': 'Blangkon Pakis',
'image': 'assets/images/blangkon1.png',
'price': 50000,
'description': 'Blangkon made in Pakis'
},
{
'name': 'Blangkon Jarit Jogja Mataraman Hitam',
'image': 'assets/images/blangkon2.png',
'price': 55000,
'description': 'Blangkon Jogja Mataraman Kumitir Hitam'
},
{
'name': 'Blangkon Jarit Jogja Mataraman Biru',
'image': 'assets/images/blangkon3.png',
'price': 60000,
'description': 'Blangkon Jogja Mataraman Kumitir Biru'
},
{
'name': 'Blangkon Jarit Jogja Mataraman Hijau',
'image': 'assets/images/blangkon4.png',
'price': 60000,
'description': 'Blangkon Jogja Mataraman Kumitir Hijau'
},
{
'name': 'Blangkon Jawa Timur',
'image': 'assets/images/blangkon5.png',

'price': 55000,
'description': 'Blangkon Khas Jawa Timur'
},
{
'name': 'Blangkon Solo Motif Jebeh',
'image': 'assets/images/blangkon6.png',
'price': 55000,
'description': 'Blangkon Surakarta Motif Batik Jebeh'
},
{
'name': 'Blangkon Alusan Jogja Hitam',
'image': 'assets/images/blangkon7.png',
'price': 70000,
'description': 'Blangkon Jogja Alusan'
},
{
'name': 'Blangkon Jarit Surakarta',
'image': 'assets/images/blangkon8.png',
'price': 65000,
'description': 'Blangkon Jarit Solo/Surakarta'
},
{
'name': 'Blangkon Jogja Motif Jebeh',
'image': 'assets/images/blangkon9.png',
'price': 55000,
'description': 'Blangkon Jogja Motif Jebeh'
},
{
'name': 'Blangkon Surakarta',
'image': 'assets/images/blangkon10.png',
'price': 75000,
'description': 'Blangkon Khas Solo Alusan'
},
];
final List<Map<String, dynamic>> _cart = [];
double _totalSales = 0;
void _addToCart(Map<String, dynamic> product) {
setState(() {
_cart.add(product);
_totalSales += product['price'];
});
}
void _showProductDetails(BuildContext context, Map<String,
dynamic> product) {

showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text(product['name']),
content: Column(
mainAxisSize: MainAxisSize.min,
children: [
Image.asset(product['image'], fit: BoxFit.cover),
const SizedBox(height: 10),
Text(product['description']),
],
),
),
);
}
void _showPaymentForm() async {
final result = await Navigator.pushNamed(
context,
'/payment',
arguments: {'total': _totalSales, 'cart': _cart},
);
if (result == true) {
setState(() {
_cart.clear();
_totalSales = 0;
});
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Pembayaran Berhasil!'),
backgroundColor: Colors.green,
),
);
}
}
Future<void> _logout() async {
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('isLoggedIn', false);
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(builder: (context) => const
LoginScreen()),
(route) => false,
);

}
Future<void> _launchMap() async {
final Uri mapUri = Uri.parse(
'https://www.google.com/maps/search/?api=1&query=-7.246634668623958, 110.53192135555446');
await launchUrl(mapUri);
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title:
const Text('Daftar Produk', style:

TextStyle(color: Colors.white)),
backgroundColor: Colors.blue,
actions: [
PopupMenuButton<String>(
onSelected: (value) {
if (value == 'Call') {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => CallCenterScreen(),
),
);
} else if (value == 'SMS') {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => SmsCenterScreen(),
),
);
} else if (value == 'Map') {
_launchMap();
} else if (value == 'Update') {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const

UpdateScreen(),
),
);
} else if (value == 'Logout') {
_logout();
}

},
itemBuilder: (context) => [
const PopupMenuItem(value: 'Call', child:

Text('Call Center')),

const PopupMenuItem(value: 'SMS', child:

Text('SMS Center')),

const PopupMenuItem(value: 'Map', child:

Text('Lokasi/Maps')),

const PopupMenuItem(
value: 'Update', child: Text('Update User & Password')),

const PopupMenuItem(value: 'Logout', child:

Text('Logout')),
],
),
],
),
body: Column(
children: [
Expanded(
child: GridView.builder(
padding: const EdgeInsets.all(10),
gridDelegate: const

SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
mainAxisSpacing: 10,
crossAxisSpacing: 10,
childAspectRatio: 2 / 2.5,
),
itemCount: _products.length,
itemBuilder: (context, index) {
final product = _products[index];
return Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
elevation: 3,
child: Column(
children: [
GestureDetector(
onTap: () => _addToCart(product),
child: ClipRRect(
borderRadius:

BorderRadius.circular(10),

child: Image.asset(
product['image'],
fit: BoxFit.cover,

width: double.infinity,
height: 100,
),
),
),
Padding(
padding: const EdgeInsets.all(8),
child: GestureDetector(
onTap: () =>
_showProductDetails(context, product),
child: SizedBox(
width: double.infinity,
child: Column(
crossAxisAlignment:

CrossAxisAlignment.start,

mainAxisSize: MainAxisSize.min,
children: [
Text(
product['name'],
style: const TextStyle(
fontWeight:

FontWeight.bold,

fontSize: 14),
textAlign: TextAlign.left,
),
const SizedBox(height: 4),
Text(
'Harga: Rp${product['price']}',

style: TextStyle(
color: Colors.grey[600],

fontSize: 12),

textAlign: TextAlign.left,
),
],
),
),
),
),
],
),
);
},
),
),
Container(
padding: const EdgeInsets.all(16),

color: Colors.grey[200],
child: GestureDetector(
onTap: _totalSales > 0 ? _showPaymentForm :

null,

child: Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [
Text(
'Total Pembelian: Rp${_totalSales.toStringAsFixed(0)}',
style: const TextStyle(
fontSize: 16, fontWeight:

FontWeight.bold),
),
],
),
),
),
],
),
);
}
}