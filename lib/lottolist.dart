import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:flutter_application_1/wallet.dart';

class Lottolist extends StatefulWidget {
  const Lottolist({Key? key}) : super(key: key);

  @override
  State<Lottolist> createState() => _LottolistState();
}

class _LottolistState extends State<Lottolist> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Wallet()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF5B1E1E),
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_lotto3.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.red.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              // Header with title and icon
              Row(
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
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),

              Image.asset(
                'assets/images/banner1.png',
              ),
              const SizedBox(height: 10),
              Text(
                'เลือกซื้อเลขที่ถูกใจ',
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 197, 2),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Lotto numbers cards
              Expanded(
                child: ListView(
                  children: [
                    _buildLottoCard('647853', 'lotto 8'),
                    _buildLottoCard('463770', 'lotto 12'),
                    _buildLottoCard('358795', 'lotto 18'),
                    _buildLottoCard('546783', 'lotto 24'),
                    _buildLottoCard('139075', 'lotto 36'),
                    _buildLottoCard('953452', 'lotto 39'),
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
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'ลอตเตอร์รี่'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'รางวัล'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'กระเป๋าเงิน'),
        ],
      ),
    );
  }

  Widget _buildLottoCard(String number, String lottoType) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [
            Color.fromARGB(255, 234, 233, 235),
            Color(0xFFE6D9AC),
            Color(0xFFA49869),
            Color(0xFF7D6738),
          ],
          center: Alignment.center,
          radius: 2.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lottoType,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            number,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
