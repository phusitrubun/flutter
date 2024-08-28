import 'package:flutter/material.dart';

class AdminPrizeAwardPage extends StatefulWidget {
  AdminPrizeAwardPage({super.key});

  @override
  State<AdminPrizeAwardPage> createState() => _AdminPrizeAwardPageState();
}

class _AdminPrizeAwardPageState extends State<AdminPrizeAwardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A0000),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper_lotto3.png', // พื้นหลังของคุณ
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: const Text(
                        'ประกาศรางวัล',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF7A0000),
                        border: Border.all(color: Colors.yellow, width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildPrizeCard('รางวัลที่ 1', 'lotto 88',
                              '1,000,000 ฿', '848322'),
                          buildPrizeCard(
                              'รางวัลที่ 2', 'lotto 21', '100,000 ฿', '463945'),
                          buildPrizeCard(
                              'รางวัลที่ 3', 'lotto 89', '10,000 ฿', '404902'),
                          buildPrizeCard(
                              'รางวัลที่ 4', 'lotto 21', '5,000 ฿', '173528'),
                          buildPrizeCard(
                              'รางวัลที่ 5', 'lotto 5', '2,000 ฿', '848322'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrizeCard(
      String prize, String lotto, String amount, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: const Color(0xFFF7E9C5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    prize,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    lotto,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
