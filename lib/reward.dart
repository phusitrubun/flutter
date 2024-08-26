import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/lottolist.dart';
import 'package:flutter_application_1/profile.dart';
import 'wallet.dart'; // Import the Wallet page

class MenuPage extends StatefulWidget {
  int idx = 0;
  MenuPage({super.key, required this.idx});
  
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Wallet(idx:widget.idx)),
      );
    }
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Lottolist(idx:widget.idx)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_lotto3.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.red.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red[900]!.withOpacity(0.8),
              Colors.red[800]!.withOpacity(0.8)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header with logo and user greeting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo_lotto.png',
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Profile icon tapped');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(idx: widget.idx),
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
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/banner1.png',
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    _buildMainPrizeCard('รางวัลที่ 1', '848322',
                        'lotto6 88 Jackpot 1,000,000 ฿'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSecondaryPrizeCard('รางวัลที่ 2',
                              '463945', 'lotto5 21 win 100,000 ฿'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSecondaryPrizeCard('รางวัลที่ 3',
                              '404902', 'lotto6 88 win 10,000 ฿'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildSecondaryPrizeCard(
                        'รางวัลที่ 4', '173528', 'lotto6 21 win 5,000 ฿'),
                    const SizedBox(height: 8),
                    _buildSecondaryPrizeCard(
                        'รางวัลที่ 5', '848322', 'lotto6 5 win 2,000 ฿'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red[900],
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.yellow[200],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'ลอตเตอร์รี่'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'รางวัล',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'กระเป๋าเงิน'),
        ],
      ),
    );
  }

  Widget _buildMainPrizeCard(String title, String number, String description) {
    return Stack(
      children: [
        Positioned(
          top: -15,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/g1.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[900]!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.yellow[700]!, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[700]!.withOpacity(0.7),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                          color: Colors.yellow[300],
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.yellow[100],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/g2.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryPrizeCard(
      String title, String number, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[800]!.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.yellow[700]!, width: 2),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[700]!.withOpacity(0.8),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 235, 190, 8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 229, 59),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
