import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/Getprizeaward.dart';

class MenuPage extends StatefulWidget {
  final int idx;
  MenuPage({Key? key, required this.idx}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<GetPrizeAward>? futurePrizeAward;

  String url = '';

  @override
  void initState() {
    super.initState();
    futurePrizeAward = fetchPrizeAward();
  }

  Future<GetPrizeAward> fetchPrizeAward() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var response = await http.get(Uri.parse('$url/getPrizeAward'));

    if (response.statusCode == 200) {
      return getPrizeAwardFromJson(response.body);
    } else {
      throw Exception('Failed to load prize award');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Container(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16.0 : 32.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/banner1.png',
                    width: isMobile ? 350 : 500,
                  ),

                  Expanded(
                    child: futurePrizeAward == null
                        ? Center(child: CircularProgressIndicator())
                        : FutureBuilder<GetPrizeAward>(
                            future: futurePrizeAward,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                return _buildPrizeList(
                                    snapshot.data!, isMobile);
                              } else {
                                return Center(child: Text('No data available'));
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrizeList(GetPrizeAward prizeAward, bool isMobile) {
    List<DtoList> sortedList = List.from(prizeAward.dtoList)
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return ListView(
      padding: EdgeInsets.all(isMobile ? 8.0 : 12.0),
      children: [
        _buildMainPrizeCard(
          'รางวัลที่ 1',
          sortedList.isNotEmpty ? '${sortedList[0].number}' : 'ยังไม่ออกรางวัล',
          sortedList.isNotEmpty
              ? 'lotto6 ${sortedList[0].lid} Jackpot ${sortedList[0].prize} ฿'
              : '',
          isMobile,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryPrizeCard(
                'รางวัลที่ 2',
                sortedList.length > 1
                    ? '${sortedList[1].number}'
                    : 'ยังไม่ออกรางวัล',
                sortedList.length > 1
                    ? 'lotto5 ${sortedList[1].lid} win ${sortedList[1].prize} ฿'
                    : '',
                isMobile,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSecondaryPrizeCard(
                'รางวัลที่ 3',
                sortedList.length > 2
                    ? '${sortedList[2].number}'
                    : 'ยังไม่ออกรางวัล',
                sortedList.length > 2
                    ? 'lotto6 ${sortedList[2].lid} win ${sortedList[2].prize} ฿'
                    : '',
                isMobile,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSecondaryPrizeCard(
          'รางวัลที่ 4',
          sortedList.length > 3 ? '${sortedList[3].number}' : 'ยังไม่ออกรางวัล',
          sortedList.length > 3
              ? 'lotto6 ${sortedList[3].lid} win ${sortedList[3].prize} ฿'
              : '',
          isMobile,
        ),
        const SizedBox(height: 8),
        _buildSecondaryPrizeCard(
          'รางวัลที่ 5',
          sortedList.length > 4 ? '${sortedList[4].number}' : 'ยังไม่ออกรางวัล',
          sortedList.length > 4
              ? 'lotto6 ${sortedList[4].lid} win ${sortedList[4].prize} ฿'
              : '',
          isMobile,
        ),
      ],
    );
  }

  Widget _buildMainPrizeCard(
      String title, String number, String description, bool isMobile) {
    return Stack(
      children: [
        Positioned(
          top: -20, // เพิ่มความสูงของตำแหน่ง
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/g1.png',
            fit: BoxFit.cover,
            width: isMobile ? 250 : 350, // ขยายขนาดรูปภาพให้ใหญ่ขึ้น
          ),
        ),
        Container(
          padding: EdgeInsets.all(isMobile ? 20.0 : 30.0), // เพิ่ม padding
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[900]!
                  .withOpacity(0.8), // เพิ่มความทึบของสีพื้นหลัง
              borderRadius: BorderRadius.circular(12), // เพิ่มความโค้งมน
              border: Border.all(
                  color: Colors.yellow[700]!, width: 3), // เพิ่มขนาดเส้นขอบ
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 8 : 12), // เพิ่มขนาดของ padding
                  decoration: BoxDecoration(
                    color: Colors.red[700]!.withOpacity(0.8),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 20, // เพิ่มขนาดตัวอักษร
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      isMobile ? 10.0 : 12.0), // เพิ่ม padding ด้านใน
                  child: Column(
                    children: [
                      Text(
                        number,
                        style: TextStyle(
                          color: Colors.yellow[300],
                          fontSize: isMobile
                              ? 28
                              : 32, // เพิ่มขนาดตัวอักษรของหมายเลขรางวัล
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.yellow[100],
                          fontSize: isMobile ? 10 : 12, // เพิ่มขนาดของคำอธิบาย
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
          top: 80, // ปรับตำแหน่งของรูปภาพให้สอดคล้องกับการ์ด
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/g2.png',
            fit: BoxFit.contain,
            width: isMobile ? 250 : 350, // เพิ่มขนาดรูปภาพด้านล่าง
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryPrizeCard(
      String title, String number, String description, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[800]!.withOpacity(0.9), // เพิ่มความเข้มของสีพื้นหลัง
        borderRadius: BorderRadius.circular(10), // เพิ่มความโค้งมนของมุม
        border: Border.all(
            color: Colors.yellow[700]!, width: 3), // เพิ่มขนาดเส้นขอบ
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: isMobile ? 8 : 12), // เพิ่ม padding
            decoration: BoxDecoration(
              color: Colors.red[700]!.withOpacity(0.9),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 235, 190, 8),
                fontSize: isMobile ? 12 : 16, // เพิ่มขนาดตัวอักษร
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 8.0 : 12.0), // เพิ่ม padding
            child: Column(
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: isMobile ? 20 : 24, // เพิ่มขนาดตัวอักษร
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 229, 59),
                    fontSize: isMobile ? 8 : 10, // เพิ่มขนาดคำอธิบาย
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
