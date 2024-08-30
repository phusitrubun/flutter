import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/allLotteryGetResponse.dart';
import 'package:flutter_application_1/shared/appData.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Lottolist extends StatefulWidget {
  final int idx;

  const Lottolist({Key? key, required this.idx}) : super(key: key);

  @override
  State<Lottolist> createState() => _LottolistState();
}

class _LottolistState extends State<Lottolist> {
  int _selectedIndex = 0;
  String url = '';
  List<AllLotteryGetResponse> lotteries = [];
  int soldCount = 0;

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

  Future<void> getAllLottery() async {
    final response = await http.get(Uri.parse("$url/getAllLottery"));

    if (response.statusCode == 200 || response.statusCode == 202) {
      if (response.body.isNotEmpty) {
        setState(() {
          try {
            List<AllLotteryGetResponse> allLotteries =
                allLotteryGetResponseFromJson(response.body);
            lotteries = allLotteries.take(100).toList();
            soldCount = lotteries.where((lotto) => lotto.status == 0).length;
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
                'เหลือ $soldCount / 100 ใบ',
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
                            lotteries[index].status == 1,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
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
              'ซื้อ Lotto',
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
                  _buyLottery(lid);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 255, 255, 255), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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

  Future<void> _buyLottery(String lid) async {
    final appData = Provider.of<AppData>(context, listen: false);
    final uid = appData.idx; // Fetching the user ID from AppData
    log('Attempting to buy lottery. User ID: $uid, Lottery ID: $lid'); // New log statement
    try {
      final response = await http.post(
        Uri.parse('$url/BuyLotterys'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "lid": int.parse(lid),
          "uid": uid,
        }),
      );

      if (response.statusCode == 200) {
        log('Lottery purchase successful. User ID: $uid, Lottery ID: $lid'); // New log statement
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ซื้อล็อตเตอรี่สำเร็จ')),
        );
        // Refresh the lottery list
        getAllLottery();
      } else if (response.statusCode == 400) {
        log('Invalid data for lottery purchase. User ID: $uid, Lottery ID: $lid'); // New log statement
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ข้อมูลไม่ถูกต้อง กรุณาลองใหม่')),
        );
      } else if (response.statusCode == 403) {
        log('Insufficient funds for lottery purchase. User ID: $uid, Lottery ID: $lid'); // New log statement
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ยอดเงินไม่เพียงพอ')),
        );
      } else {
        log('Error in lottery purchase. Status code: ${response.statusCode}, User ID: $uid, Lottery ID: $lid'); // New log statement
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดในการซื้อ')),
        );
      }
    } catch (e) {
      log('Exception in buyLottery: $e. User ID: $uid, Lottery ID: $lid'); // Updated log statement
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการซื้อ')),
      );
    }
  }
}
