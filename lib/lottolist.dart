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
    // Get the screen size for responsive adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
          child: SingleChildScrollView(
            // Wrap the entire content in a SingleChildScrollView
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/banner1.png',
                    width: screenWidth * 0.8, // Responsive image width
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'เลือกซื้อเลขที่ถูกใจ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 227, 197, 2),
                      fontSize: screenWidth * 0.06, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'เหลือ $soldCount / 100 ใบ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04, // Responsive font size
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Lottery list section
                  SizedBox(
                    height: screenHeight * 0.6, // Responsive container height
                    child: lotteries.isEmpty
                        ? Center(
                            child: Text(
                              'ไม่พบข้อมูลล็อตเตอรี่',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            itemCount: lotteries.length,
                            itemBuilder: (context, index) {
                              final lottery = lotteries[index];
                              return _buildLottoCard(
                                lottery.number.toString(),
                                'lotto ${lottery.lid}',
                                lottery.status,
                                screenWidth, // Pass screen width for responsiveness
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLottoCard(
      String number, String lottoType, int status, double screenWidth) {
    Color statusColor;
    String statusText;

    // ตรวจสอบสถานะและกำหนดสีและข้อความ
    if (status == 2) {
      statusColor = Colors.green;
      statusText = 'ถูกรางวัล';
    } else if (status == 3) {
      statusColor = Colors.red;
      statusText = 'ไม่ถูกรางวัล';
    } else if (status == 4) {
      statusColor = const Color.fromARGB(255, 209, 165, 5);
      statusText = 'ขึ้นรางวัลแล้ว';
    } else if (status == 1) {
      statusColor = Colors.red;
      statusText = 'ขายแล้ว';
    } else {
      statusColor = Colors.transparent;
      statusText = ''; // No status text for unsold lotteries
    }

    // ตรวจสอบว่ามีลอตเตอรี่ที่ถูกรางวัล (status == 2) อยู่ในรายการหรือไม่
    bool hasWinningLottery = lotteries.any((lotto) => lotto.status >= 2);

    return Stack(
      children: [
        GestureDetector(
          // กดซื้อได้เมื่อสถานะเป็น 0 และยังไม่มีลอตเตอรี่ที่ถูกรางวัล
          onTap: (status == 0 && !hasWinningLottery)
              ? () => _showConfirmationDialog(number, lottoType.split(' ')[1])
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.04,
              horizontal: screenWidth * 0.05,
            ),
            margin: EdgeInsets.only(bottom: screenWidth * 0.03),
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
                    fontSize: screenWidth * 0.04, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  number,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.06, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (statusText.isNotEmpty)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03, vertical: screenWidth * 0.01),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                statusText,
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
    final screenWidth = MediaQuery.of(context).size.width;

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
                fontSize: screenWidth * 0.06, // Responsive font size
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: screenWidth * 0.08, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenWidth * 0.03),
              Text(
                '100 บาท',
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // Responsive font size
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
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenWidth * 0.03),
                ),
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
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
    log('Attempting to buy lottery. User ID: $uid, Lottery ID: $lid');
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
        log('Lottery purchase successful. User ID: $uid, Lottery ID: $lid');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ซื้อล็อตเตอรี่สำเร็จ')),
        );
        // Refresh the lottery list
        getAllLottery();
      } else if (response.statusCode == 400) {
        log('Invalid data for lottery purchase. User ID: $uid, Lottery ID: $lid');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ข้อมูลไม่ถูกต้อง')),
        );
      } else if (response.statusCode == 404) {
        log('Lottery not found. User ID: $uid, Lottery ID: $lid');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่พบล็อตเตอรี่')),
        );
      } else {
        log('Failed to purchase lottery: ${response.statusCode}');
        throw Exception('Failed to purchase lottery');
      }
    } catch (e) {
      log('An error occurred while purchasing lottery: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด')),
      );
    }
  }
}
