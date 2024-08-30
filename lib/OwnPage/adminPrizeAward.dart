import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/awardRankPrizePostResponse.dart';
import 'package:flutter_application_1/models/response/lotteriesRankPrizeGetResponse.dart';
import 'package:http/http.dart' as http;

class AdminPrizeAwardPage extends StatefulWidget {
  AdminPrizeAwardPage({super.key});

  @override
  State<AdminPrizeAwardPage> createState() => _AdminPrizeAwardPageState();
}

class _AdminPrizeAwardPageState extends State<AdminPrizeAwardPage> {
  String url = '';
  late LotteriesRankPrizeGetResponse lotteriesRankPrize;
  late AwardRankPrizePostResponse awardRankPrize;
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getLotteriesPrizeRank();
  }

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
                      onPressed: () {
                        AwardPrizeOwn();
                      },
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
                FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (lotteriesRankPrize.dtoList.isEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF7A0000),
                            border: Border.all(color: Colors.yellow, width: 2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "ยังไม่มีการประกาศในฐานข้อมูล",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        );
                      }
                      return Expanded(
                        child: Center(
                          child: ListView.builder(
                            itemCount: lotteriesRankPrize.dtoList.length,
                            itemBuilder: (context, index) {
                              final LotteriesRank =
                                  lotteriesRankPrize.dtoList[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7A0000),
                                  border: Border.all(
                                      color: Colors.yellow, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildPrizeCard(
                                        'รางวัลที่ ${LotteriesRank.rank}',
                                        'lotto ${LotteriesRank.lid}',
                                        '${LotteriesRank.prize} ฿',
                                        '${LotteriesRank.number}')
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
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

  Future<void> getLotteriesPrizeRank() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var response = await http.get(Uri.parse('$url/getPrizeAward'));
    if (response.body.length > 0) {
      lotteriesRankPrize = lotteriesRankPrizeGetResponseFromJson(response.body);
      // setState(() {
      //   lotteriesRankPrize=null;
      //   lotteriesRankPrize.dtoList = [];
      // });
    }
  }

  void showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    Color? iconColor,
    Color? okButtonColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: 60,
                  ), // Add the icon with the specified color
                 
                ],
              ),
               Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title),
                    ],
                  ),
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Add your custom action here
                  },
                  child: const Text("ตกลง"),
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                     backgroundColor: okButtonColor, // Set the OK button color
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void AwardPrizeOwn() async {
    var awardPrize = await http.post(Uri.parse("$url/AwardPrize"));
    if (awardPrize.body.length >= 0) {
      awardRankPrize = awardRankPrizePostResponseFromJson(awardPrize.body);
      log(awardRankPrize.message);
      if (awardRankPrize.message == "รายการลำดับค้นหา") {
        showCustomDialog(
          context,
          title: "ประกาศรางวัลสำเร็จ ",
          content: "ประกาศรายการสำเร็จ 5 รางวัล.",
          icon: Icons.check_circle_outline_rounded, // Set your desired icon
          iconColor:
              Colors.green, // Set the icon color// Set the cancel button color
          okButtonColor: Colors.green, // Set the OK button color
        );
        setState(() {
          getLotteriesPrizeRank();
        });
      } else if (awardRankPrize.message == "มีรายการลำดับในฐานข้อมูลอยู่แล้ว") {
          showCustomDialog(
          context,
          title: "ประกาศรางวัลไม่สำเร็จ ",
          content: "มีการประกาศรางวัลอยู่แล้ว",
          icon: Icons.error_outline_rounded, // Set your desired icon
          iconColor:
              Colors.red, // Set the icon color// Set the cancel button color
          okButtonColor: Colors.red, // Set the OK button color
        );
        setState(() {
          getLotteriesPrizeRank();
        });
      }
      else if(awardRankPrize.message=="ไม่พบรายการล็อตเตอรี่ที่มีเจ้าของ"){
        showCustomDialog(
          context,
          title: "ประกาศรางวัลไม่สำเร็จ ",
          content: "ไม่พบรายการล็อตเตอรี่ที่มีเจ้าของ",
          icon: Icons.error_outline_rounded, // Set your desired icon
          iconColor:
              Colors.red, // Set the icon color// Set the cancel button color
          okButtonColor: Colors.red, // Set the OK button color
        );
        setState(() {
          getLotteriesPrizeRank();
        });
      }
      else if(awardRankPrize.message=="รายการล็อตเตอรี่ที่มีเจ้าของยังไม่ถึงยอด"){
          showCustomDialog(
          context,
          title: "ประกาศรางวัลไม่สำเร็จ ",
          content: "ล็อคเตอรี่ยังขายไม่ได้ถึงยอดที่จะออกรางวัล",
          icon: Icons.error_outline_rounded, // Set your desired icon
          iconColor:
              Colors.red, // Set the icon color// Set the cancel button color
          okButtonColor: Colors.red, // Set the OK button color
        );
        setState(() {
          getLotteriesPrizeRank();
        });

      }
    }
  }
}
