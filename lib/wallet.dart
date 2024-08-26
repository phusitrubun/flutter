import 'package:flutter/material.dart';
import 'package:flutter_application_1/lottolist.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/reward.dart';

class Wallet extends StatefulWidget {
  int idx = 0;
  Wallet({super.key, required this.idx});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage(idx: widget.idx)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              // Header with logo and user greeting
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
                          builder: (context) =>  Profile(idx:widget.idx),
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
              const SizedBox(height: 20),
              // Wallet Balance Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFF7D6738),
                      Color(0xFFA49869),
                      Color(0xFFE6D9AC),
                      Color.fromARGB(255, 234, 233, 235),
                    ],
                    center: Alignment.centerLeft,
                    radius: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ยอดเงินทั้งหมด',
                      style: TextStyle(
                        color: Color.fromARGB(255, 88, 59, 39),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '7,200 ฿',
                          style: TextStyle(
                            color: Color(0xFF3D1B0F),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'winning lotto +2,000',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Purchase History Header
              Text(
                'รายการที่ซื้อ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Purchase History List
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Color(0xFFEDE6D5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รายการที่ซื้อ',
                              style: TextStyle(
                                color: Color(0xFF7D5538),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Define your action here
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.zero, // Remove default padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors
                                    .transparent, // Make the button background transparent
                                shadowColor:
                                    Colors.transparent, // Remove the shadow
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFE3BB66), // The yellowish color
                                      Color(0xFFB81A1B), // The reddish color
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'เช็ครางวัล',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            _buildPurchaseItem('249531', 'lotto 53', '-200'),
                            _buildPurchaseItem(
                                '848322', 'lotto win 5', '+2,000'),
                            _buildPurchaseItem('686345', 'lotto 21', '-200'),
                            _buildPurchaseItem('299361', 'lotto 38', '-200'),
                          ],
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildPurchaseItem(String number, String lottoType, String winnings) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [
            Color(0xFFFDFCFF),
            Color(0xFFE6D9AC),
            Color(0xFFA49869),
            Color(0xFF7D6738),
          ],
          center: Alignment.center,
          radius: 2.5,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            number,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                lottoType,
                style: TextStyle(
                  color: Color.fromARGB(255, 52, 42, 42),
                  fontSize: 14,
                ),
              ),
              if (winnings.isNotEmpty)
                Text(
                  winnings,
                  style: TextStyle(
                    color: winnings.startsWith('+') ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
