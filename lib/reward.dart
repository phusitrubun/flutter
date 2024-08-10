import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
              Image.asset('assets/images/banner1.png'),
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

  Widget _buildMainPrizeCard(String title, String number, String description) {
    return Stack(
      children: [
        Positioned(
          top: -15, // ปรับตำแหน่งตามต้องการ
          left: 0, // ปรับตำแหน่งตามต้องการ
          right: 0,
          child: Image.asset(
            'assets/images/g1.png', // รูปภาพพื้นหลังเดิม
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(40), // ลด padding ลง
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[900]!
                  .withOpacity(0.7), // ปรับความโปร่งแสงให้ชัดเจนขึ้น
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.yellow[700]!, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4), // ลด padding ลง
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
                        fontSize: 14, // ลดขนาดฟอนต์ลง
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10), // ลด padding ลง
                  child: Column(
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                          color: Colors.yellow[300],
                          fontSize: 28, // ลดขนาดฟอนต์ลง
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                            color: Colors.yellow[100],
                            fontSize: 10), // ลดขนาดฟอนต์ลง
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 90, // ปรับตำแหน่งตามต้องการ
          left: 0, // ปรับตำแหน่งตามต้องการ
          right: 0, // ปรับตำแหน่งตามต้องการ
          child: Image.asset(
            'assets/images/g2.png', // รูปภาพใหม่ที่อยู่ด้านบนสุด
            fit: BoxFit.contain, // ปรับตามต้องการ
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
            padding: const EdgeInsets.symmetric(vertical: 8), // Reduced padding
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
                  fontSize: 12, // Reduced font size
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8), // Reduced padding
            child: Column(
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20, // Reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 229, 59),
                      fontSize: 8), // Reduced font size
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
