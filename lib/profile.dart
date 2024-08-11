import 'package:flutter/material.dart';
import 'package:flutter_application_1/lottolist.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:flutter_application_1/wallet.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // User Details Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.yellow[700]!, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'MadisonBrr',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'อีเมล',
                      style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'madi@eachdaygoesby',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'ยอดเงินคงเหลือ',
                      style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '7,200 ฿',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logout function or action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700], // background color
                  foregroundColor: Colors.white, // text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                ),
                child: Text(
                  'ออกจากระบบ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        currentIndex: 2, // Assuming the Profile page is the third item
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'ลอตเตอร์รี่'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'รางวัล'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'กระเป๋าเงิน'),
        ],
        onTap: (index) {
          // Navigate to other pages based on the selected index
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lottolist()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Wallet()),
            );
          }
        },
      ),
    );
  }
}
