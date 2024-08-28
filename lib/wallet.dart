import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/response/profileGetResponse.dart';
import 'package:flutter_application_1/models/response/getLotteryOwner.dart';
import 'package:flutter_application_1/config/config.dart';

class Wallet extends StatefulWidget {
  final int idx;
  Wallet({Key? key, required this.idx}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String url = '';
  late ProfileGetResponse profileRes;
  late GetLotteryOwner lotteryOwnerRes;
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    // Fetch profile data
    var profileResponse =
        await http.get(Uri.parse('$url/getByID/${widget.idx}'));
    profileRes = profileGetResponseFromJson(profileResponse.body);

    // Fetch lottery data
    var lotteryResponse =
        await http.get(Uri.parse('$url/getLotteryOwner/${widget.idx}'));
    lotteryOwnerRes = getLotteryOwnerFromJson(lotteryResponse.body);

    log(json.encode(profileRes.toJson()));
    log(json.encode(lotteryOwnerRes.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  const SizedBox(height: 20),
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
                    child: Row(
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
                              '${profileRes.wallet} ฿',
                              style: TextStyle(
                                color: Color(0xFF3D1B0F),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'รายการที่ซื้อ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'จำนวน: ${lotteryOwnerRes.lotterylist.length} ใบ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                                    // Implement check rewards functionality
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFE3BB66),
                                          Color(0xFFB81A1B),
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
                            child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: lotteryOwnerRes.lotterylist.length,
                              itemBuilder: (context, index) {
                                final lottery =
                                    lotteryOwnerRes.lotterylist[index];
                                return _buildPurchaseItem(
                                  lottery.number.toString(),
                                  'รอใส่สถานะรางวัล',
                                  lottery.price.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPurchaseItem(String number, String lottoType, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 234, 233, 235),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF3D1B0F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            lottoType,
            style: const TextStyle(
              color: Color(0xFF3D1B0F),
              fontSize: 14,
            ),
          ),
          Text(
            'เงินรางวัล ฿',
            style: const TextStyle(
              color: Color(0xFF3D1B0F),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
