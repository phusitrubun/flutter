import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/lottolist.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/mainlotto.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:flutter_application_1/wallet.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:provider/provider.dart';

import 'shared/appData.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansThaiTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Mainlotto(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      log('Selected Index: $_selectedIndex');
    });
  }

  Widget _getSelectedPage(int index) {
    final appData = context.watch<AppData>();

    log('AppData idx: ${appData.idx}');

    switch (index) {
      case 0:
        return Lottolist(idx: appData.idx);
      case 1:
        return MenuPage(idx: appData.idx);
      case 2:
        return Wallet(idx: appData.idx);
      default:
        return const Mainlotto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo_lotto.png',
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                log('Profile icon tapped');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Profile(idx: context.read<AppData>().idx),
                  ),
                );
              },
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: _getSelectedPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red[900],
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.yellow[200],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'ลอตเตอร์รี่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'รางวัล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'กระเป๋าเงิน',
          ),
        ],
      ),
    );
  }
}
