import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/appData.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/response/profileGetResponse.dart';
import 'package:flutter_application_1/models/response/getLotteryOwner.dart';
import 'package:flutter_application_1/models/response/checkLottery.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// New import for AwardRankPrizePostResponse
import 'package:flutter_application_1/models/response/awardRankPrizePostResponse.dart';

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
  late CheckLottery checkLotteryRes;
  late Future<void> loadData;
  bool canCheckPrize = false;

  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  bool isDataLoaded = false;

  Future<void> loadDataAsync() async {
    // Check if data has already been loaded
    if (isDataLoaded) return;

    // Your logic for loading data goes here
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var profileResponse =
        await http.get(Uri.parse('$url/getByID/${widget.idx}'));
    profileRes = profileGetResponseFromJson(profileResponse.body);

    var lotteryResponse =
        await http.get(Uri.parse('$url/getLotteryOwner/${widget.idx}'));
    lotteryOwnerRes = getLotteryOwnerFromJson(lotteryResponse.body);

    await loadSavedLotteryCheckResults();

    log(json.encode(profileRes.toJson()));
    log(json.encode(lotteryOwnerRes.toJson()));

    // After loading data, set isDataLoaded to true
    isDataLoaded = true;
  }

  Future<void> loadSavedLotteryCheckResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedResults = prefs.getString('checkLotteryRes_${widget.idx}');
    setState(() {
      if (savedResults != null) {
        checkLotteryRes = CheckLottery.fromJson(json.decode(savedResults));
      } else {
        checkLotteryRes =
            CheckLottery(results: [], totalCount: 0); // เพิ่ม totalCount
      }
    });
  }

  // Save the results to SharedPreferences
  Future<void> saveLotteryCheckResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'checkLotteryRes_${widget.idx}', json.encode(checkLotteryRes.toJson()));
  }

  // Function to check lottery prize
  Future<void> checkPrize(int uid) async {
    var checkLotteryResponse = await http
        .get(Uri.parse('$url/CheckLottery/${context.read<AppData>().idx}'));

    if (checkLotteryResponse.statusCode == 200) {
      var responseBody = json.decode(checkLotteryResponse.body);
      if (responseBody['results'] != null &&
          responseBody['results'].isNotEmpty) {
        setState(() {
          checkLotteryRes = checkLotteryFromJson(checkLotteryResponse.body);
          checkLotteryRes.totalCount =
              checkLotteryRes.results.length; // อัปเดต totalCount
        });
        await saveLotteryCheckResults();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ตรวจสอบรางวัลเรียบร้อยแล้ว'),
          ),
        );
      } else {
        // Handle empty results
        var awardResponse = AwardRankPrizePostResponse.fromJson(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(awardResponse.message),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('เกิดข้อผิดพลาดในการตรวจสอบรางวัล'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF5B1E1E),
              image: DecorationImage(
                image: const AssetImage('assets/images/wallpaper_lotto3.png'),
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

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16.0 : 32.0,
                          vertical: 30.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Wallet balance container
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ยอดเงินทั้งหมด',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 88, 59, 39),
                                      fontSize: isMobile ? 16.0 : 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${profileRes.wallet} ฿',
                                        style: TextStyle(
                                          color: const Color(0xFF3D1B0F),
                                          fontSize: isMobile ? 20.0 : 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            // Purchased items header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'รายการที่ซื้อ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 16.0 : 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'จำนวน: ${lotteryOwnerRes.lotterylist.length} ใบ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 14.0 : 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            // Purchased items container header
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xFFEDE6D5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'รายการที่ซื้อ',
                                    style: TextStyle(
                                      color: const Color(0xFF7D5538),
                                      fontSize: isMobile ? 16.0 : 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        checkPrize(context.read<AppData>().idx),
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
                                        gradient: const LinearGradient(
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 25),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'เช็ครางวัล',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isMobile ? 14.0 : 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 540,
                              child: lotteryOwnerRes.lotterylist.isEmpty
                                  ? Center(
                                      child: Text(
                                        'ไม่มีรายการที่ซื้อ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isMobile ? 14.0 : 16.0,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.all(10),
                                      itemCount:
                                          lotteryOwnerRes.lotterylist.length,
                                      itemBuilder: (context, index) {
                                        final lottery =
                                            lotteryOwnerRes.lotterylist[index];
                                        final prizeInfo =
                                            checkLotteryRes.results.firstWhere(
                                          (result) => result.lid == lottery.lid,
                                          orElse: () => Result(
                                            lid: 0,
                                            number: 0,
                                            status: 0,
                                            textStatus: 'ไม่พบข้อมูล',
                                            uid: 0,
                                            prize: 0,
                                            rank: 0,
                                          ),
                                        );
                                        return _buildPurchaseItem(
                                          lottery.number.toString(),
                                          checkLotteryRes.results.isNotEmpty
                                              ? prizeInfo.status ?? 0
                                              : 0,
                                          lottery.price.toString(),
                                          prizeInfo.prize ?? 0,
                                          lottery.lid,
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPurchaseItem(
      String number, int status, String price, int prize, int lid) {
    String statusText;
    Color statusColor;

    if (status == 0 || status == 1) {
      if (checkLotteryRes == null) {
        // Before checking, show "รอดำเนินการ" for all status 1
        statusText = 'รอดำเนินการ';
        statusColor = const Color.fromARGB(255, 255, 157, 0);
      } else {
        // After checking, status is updated accordingly
        if (status == 2) {
          statusText = 'ถูกรางวัล';
          statusColor = Colors.green;
        } else if (status == 3) {
          statusText = 'ไม่ถูกรางวัล';
          statusColor = Colors.red;
        } else if (status == 4) {
          statusText = 'ขึ้นรางวัลแล้ว';
          statusColor = Colors.yellow[700]!;
        } else {
          statusText = 'รอออกรางวัล';
          statusColor = const Color.fromARGB(255, 255, 157, 0);
        }
      }
    } else if (status == 2) {
      statusText = 'ถูกรางวัล';
      statusColor = Colors.green;
    } else if (status == 3) {
      statusText = 'ไม่ถูกรางวัล';
      statusColor = Colors.red;
    } else if (status == 4) {
      statusText = 'ขึ้นรางวัลแล้ว';
      statusColor = Colors.yellow[700]!;
    } else {
      statusText = 'รอออกรางวัล';
      statusColor = const Color.fromARGB(255, 255, 157, 0);
    }

    return GestureDetector(
      onTap: () {
        if (status == 2) {
          showPrizeDialog(prize, number, lid);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 233, 235),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: statusColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'เลขที่: $number',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5B1E1E),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                Text(
                  'รางวัล: $prize ฿',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'ราคา: $price ฿',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showPrizeDialog(int prizeAmount, String lotteryNumber, int lid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xFF5B1E1E),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(color: Colors.amber, width: 2),
                image: const DecorationImage(
                    image: AssetImage('assets/images/bg_dialog.png'),
                    fit: BoxFit.contain)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
                const Text(
                  'ยินดีด้วย',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'คุณถูกลอตเตอรี่',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lotteryNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '+ $prizeAmount ฿',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateWallet(prizeAmount,
                        lid); // Pass lid to the updateWallet method
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'ขึ้นเงิน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateWallet(int prizeAmount, int lid) async {
    var response = await http.put(
      Uri.parse('$url/RedeemThePrize/${profileRes.uid}/$lid'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      setState(() {
        profileRes.wallet += prizeAmount;

        final index = lotteryOwnerRes.lotterylist
            .indexWhere((lottery) => lottery.lid == lid);
        if (index != -1) {
          lotteryOwnerRes.lotterylist[index].status = 4;
        }

        // Update the checkLotteryRes to reflect the redeemed prize
        if (checkLotteryRes != null) {
          final resultIndex =
              checkLotteryRes.results.indexWhere((result) => result.lid == lid);
          if (resultIndex != -1) {
            checkLotteryRes.results[resultIndex].status = 4;
          }
        }
      });

      await saveLotteryCheckResults();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ยอดเงินของคุณถูกอัพเดตแล้ว'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('การอัพเดตยอดเงินล้มเหลว'),
        ),
      );
    }
  }
}
