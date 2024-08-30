import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/lotteriesOwnAndOnStoreGetResponse.dart';

import 'package:http/http.dart' as http;

class AdminShowLotterie extends StatefulWidget {
  AdminShowLotterie({super.key});

  @override
  State<AdminShowLotterie> createState() => _AdminShowLotterieState();
}

class _AdminShowLotterieState extends State<AdminShowLotterie> {
  String url = "";
  late LotteriesIOwnAndOnStoreGetResponse lotteriesSoldOutFound;
  late LotteriesIOwnAndOnStoreGetResponse lotteriesOnStoreFound;
  late Future<void> loadData;
  bool isStoreShow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = CheckLotteryEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A0000), // Background color
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/wallpaper_lotto3.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
                future: loadData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (lotteriesOnStoreFound.lotteries.isEmpty &&
                      lotteriesSoldOutFound.lotteries.isEmpty) {
                    return AllEmpty();
                  } else {
                    return Column(children: [
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isStoreShow = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7A0000),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                                child: const Text(
                                  'ลอตโต้ที่เหลือ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                   setState(() {
                                    isStoreShow = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7A0000),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                ),
                                child: const Text(
                                  'ขายแล้ว',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: (isStoreShow)
                              ? (lotteriesOnStoreFound.lotteries.isNotEmpty)
                                  ? lotteriesOnStore()
                                  : lotteriesOnStoreEmpty()
                              : (lotteriesSoldOutFound.lotteries.isNotEmpty)
                                  ? lotteriesSoldout()
                                  : lotterySoldOutEmpty()
                        ),
                      )
                    ]);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget lotteriesOnStore() {
    return Column(
      children: [
        SizedBox(height: 20), // Spacing above the container
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFFD700),
              width: 2,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: lotteriesOnStoreFound.lotteries.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7E7B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'lotto ${e.lid}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          e.number.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget lotteriesSoldout() {
    return Column(
      children: [
        SizedBox(height: 20), // Spacing above the container
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFFD700),
              width: 2,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: lotteriesSoldOutFound.lotteries.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7E7B0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'lotto ${e.lid}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          e.number.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> CheckLotteryEmpty() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var onStoreResponse = await http.get(Uri.parse('$url/getLotteryOnStore'));
    var soldOutResponse = await http.get(Uri.parse('$url/getLotterySoldOwn'));
    lotteriesOnStoreFound =
        lotteriesIOwnAndOnStoreGetResponseFromJson(onStoreResponse.body);
    lotteriesSoldOutFound =
        lotteriesIOwnAndOnStoreGetResponseFromJson(soldOutResponse.body);
    //  lotteriesOnStoreFound.lotteries=[];
    // lotteriesSoldOutFound.lotteries=[];
  }

  Widget lotteriesOnStoreEmpty() {
    return Column(
      children: [
        SizedBox(height: 40,),
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          decoration: BoxDecoration(
            color: const Color(0xFF7A0000),
            border: Border.all(color: Colors.yellow, width: 2),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.money,
                color: Colors.white,
                size: 50,
              ),SizedBox(height: 20,),
              Text(
                "ล็อตเตอรี่ของท่านหมดแล้ว",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget lotterySoldOutEmpty() {
    return Column(
      children: [
        SizedBox(height: 40,),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              color: Colors.red[900],
              border: Border.all(color: Colors.yellow, width: 2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(height: 20,),
                Text(
                  "ล็อตเตอรี่ของท่านยังไม่ถูกขายสักใบ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
   Widget AllEmpty() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[900],
          border: Border.all(color: Colors.yellow, width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
            SizedBox(height: 20,),
            Text(
              "ล็อตเตอรี่ของท่านยังไม่ถูกขึ้นกระดานใหม่",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
   }

}
