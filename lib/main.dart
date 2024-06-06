import 'package:cycle_sort/CycleSortPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F7F8),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  'Cycle Sort',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF495E57)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Selamat Datang di Aplikasi Mobile dengan Program Cycle Sort',
                  style: TextStyle(fontSize: 18, color: Color(0xFF495E56)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset('lib/images/unpri.png'),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CycleSortPg()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF4CE14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                    child: Text(
                      'Mulai',
                      style: TextStyle(
                        color: Color(0xFF495E57),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Dibuat Oleh : \n Yahya Septian Siregar 223303030213',
                    style: TextStyle(fontSize: 15, color: Color(0xFF495E57)),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
