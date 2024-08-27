import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/AllLotteryGetResponse.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:flutter_application_1/wallet.dart';
import 'package:http/http.dart' as http;

class Lottolist extends StatefulWidget {
  int idx = 0;
  Lottolist({super.key, required this.idx});

  @override
  State<Lottolist> createState() => _LottolistState();
}

class _LottolistState extends State<Lottolist> {
  int _selectedIndex = 0;
  String url = '';
  List<AllLotteryGetResponse> lotteries = [];

  @override
  void initState() {
    super.initState();
    log('initState called');
    Configuration.getConfig().then((config) {
      log('Config loaded, API endpoint: ${config['apiEndpoint']}');
      setState(() {
        url = config['apiEndpoint'];
      });
      getAllLottery();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Wallet(idx: widget.idx)),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage(idx: widget.idx)),
      );
    }
  }

  Future<void> getAllLottery() async {
    log('Fetching lottery data from: $url/getAllLottery');
    final response = await http.get(Uri.parse("$url/getAllLottery"));

    log('Response status code: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 202) {
      if (response.body.isNotEmpty) {
        setState(() {
          try {
            List<AllLotteryGetResponse> allLotteries =
                allLotteryGetResponseFromJson(response.body);
            lotteries = allLotteries.take(100).toList();
            log('Parsed lotteries: ${lotteries.length} items');
            for (var lottery in lotteries) {
              log('Lottery Number: ${lottery.number}, Lottery ID: ${lottery.lid}, Status: ${lottery.status}');
            }
          } catch (e) {
            log('Error parsing JSON: $e');
          }
        });
      } else {
        log('Response body is empty');
      }
    } else {
      log('Failed to load lottery data: ${response.statusCode}');
      throw Exception('Failed to load lottery data');
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo_lotto.png',
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(idx: widget.idx),
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
              Text(
                'แสดง ${lotteries.length} รายการแรก',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: lotteries.isEmpty
                    ? Center(
                        child: Text('ไม่พบข้อมูลล็อตเตอรี่',
                            style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                        itemCount: lotteries.length,
                        itemBuilder: (context, index) {
                          return _buildLottoCard(
                            lotteries[index].number.toString(),
                            'lotto ${lotteries[index].lid}',
                            lotteries[index].status == 1, // Check if sold
                          );
                        },
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

  Widget _buildLottoCard(String number, String lottoType, bool isSold) {
    return Stack(
      children: [
        GestureDetector(
          onTap: isSold
              ? null
              : () => _showConfirmationDialog(number, lottoType.split(' ')[1]),
          child: Container(
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
          ),
        ),
        if (isSold)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'ขายแล้ว',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _showConfirmationDialog(String number, String lid) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'ซื้อ lotto',
              style: TextStyle(
                color: Color.fromARGB(255, 227, 197, 2),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '100 บาท',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _buyLottery(lid, widget.idx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 255, 255, 255), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15), 
                ),
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Color(0xFF5B1E1E), // Background color of the dialog
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Rounded corners for the dialog
          ),
        );
      },
    );
  }

  Future<void> _buyLottery(String lid, int uid) async {
    try {
      final response = await http.post(
        Uri.parse('$url/BuyLotterys'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "lid": lid,
          "uid": uid,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ซื้อล็อตเตอรี่สำเร็จ')),
        );
        // รีเฟรชรายการล็อตเตอรี่
        getAllLottery();
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ข้อมูลไม่ถูกต้อง กรุณาลองใหม่')),
        );
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ยอดเงินไม่เพียงพอ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดในการซื้อ')),
        );
      }
    } catch (e) {
      log('Error in buyLottery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการซื้อ')),
      );
    }
  }
}
