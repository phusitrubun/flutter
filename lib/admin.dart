import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/lotteriesOwnAndOnStoreGetResponse.dart';

import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  int idx = 0;
  Admin({super.key, required this.idx});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String url = "";
  late LotteriesIOwnAndOnStoreGetResponse lotteriesFound;
  late Future<void> loadData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = getLotteryOnStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A0000), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0000),
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            // Action when the title is tapped
            print("Title tapped!");
          },
          child: const Text(
            'ขึ้นกระดานเลขใหม่',
            style: TextStyle(
              color: Color(0xFFFFD700), // Gold color
              fontSize: 24, // Adjust font size to match image
            ),
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              'assets/images/logo_lotto.png'), // Replace with your logo path
        ),
      ),
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
            child: Column(
              children: [
                // Top button (สุ่มลอตเตอรี่)
                ElevatedButton(
                  onPressed: () {
                    // Action for "สุ่มลอตเตอรี่"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A0000),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Text(
                    'สุ่มลอตเตอรี่',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                // Bottom buttons (ลอตโต้ที่เหลือ & ขายแล้ว)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => getLotteryOnStore(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A0000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: const Text(
                        'ลอตโต้ที่เหลือ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => getLotterieSoldOut(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A0000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: const Text(
                        'ขายแล้ว',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Lottery number list
                FutureBuilder(
                    future: loadData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red[900]?.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFFFD700), width: 2),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: ListView.builder(
                            itemCount: lotteriesFound.lotteries.length,
                            itemBuilder: (context, index) {
                              final lotteries = lotteriesFound.lotteries[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7E7B0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'lotto ${lotteries.lid}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        lotteries.number.toString(),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF7A0000),
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'สุ่มลอตเตอรี่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'ประกาศรางวัล',
          ),
        ],
      ),
    );
  }

  Future<void> getLotteryOnStore() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    var response = await http.get(Uri.parse('$url/getLotteryOnStore'));
    setState(() {
      lotteriesFound = lotteriesIOwnAndOnStoreGetResponseFromJson(response.body);
      log(json.encode(lotteriesFound.toJson()));
    });
  }

  getLotterieSoldOut() async {
    var response = await http.get(Uri.parse('$url/getLotterySoldOwn'));
    setState(() {
      lotteriesFound = lotteriesIOwnAndOnStoreGetResponseFromJson(response.body);
    });
  }
}
