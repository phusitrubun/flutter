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
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/banner1.png',
              ),
              // const SizedBox(height: 10),
              Expanded(
                child: futurePrizeAward == null
                    ? Center(child: CircularProgressIndicator())
                    : FutureBuilder<GetPrizeAward>(
                        future: futurePrizeAward,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return _buildPrizeList(snapshot.data!);
                          } else {
                            return Center(child: Text('No data available'));
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrizeList(GetPrizeAward prizeAward) {
    List<DtoList> sortedList = List.from(prizeAward.dtoList)
      ..sort((a, b) => a.rank.compareTo(b.rank));

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _buildMainPrizeCard('รางวัลที่ 1', '${sortedList[0].number}',
            'lotto6 ${sortedList[0].lid} Jackpot ${sortedList[0].prize} ฿'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryPrizeCard(
                  'รางวัลที่ 2',
                  '${sortedList[1].number}',
                  'lotto5 ${sortedList[1].lid} win ${sortedList[1].prize} ฿'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSecondaryPrizeCard(
                  'รางวัลที่ 3',
                  '${sortedList[2].number}',
                  'lotto6 ${sortedList[2].lid} win ${sortedList[2].prize} ฿'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildSecondaryPrizeCard('รางวัลที่ 4', '${sortedList[3].number}',
            'lotto6 ${sortedList[3].lid} win ${sortedList[3].prize} ฿'),
        const SizedBox(height: 8),
        _buildSecondaryPrizeCard('รางวัลที่ 5', '${sortedList[4].number}',
            'lotto6 ${sortedList[4].lid} win ${sortedList[4].prize} ฿'),
      ],
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
