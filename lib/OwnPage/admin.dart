import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/OwnPage/adminAddNewLotteryBoard.dart';
import 'package:flutter_application_1/OwnPage/adminPrizeAward.dart';
import 'package:flutter_application_1/OwnPage/adminShowLotteries.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/response/lotteriesOwnAndOnStoreGetResponse.dart';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  int idx = 0;
  Admin({super.key, required this.idx});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;
  String url = "";
  late LotteriesIOwnAndOnStoreGetResponse lotteriesFound;
  late Future<void> loadData;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    loadData = getLotteryOnStore();

    _pages.add(AdminShowLotterie(idx: widget.idx));
    _pages.add(AddNewLotteryBoard(idx: widget.idx));
    _pages.add(AdminPrizeAwardPage(idx:widget.idx));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A0000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0000),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo_lotto.png'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.amber[600],
            ),
            onPressed: () {
              // เช่น ล้าง session หรือไปยังหน้า login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF7A0000),
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'สุ่มลอตเตอรี่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_attraction_outlined),
            label: 'ขึ้นกระดานใหม่',
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
      lotteriesFound =
          lotteriesIOwnAndOnStoreGetResponseFromJson(response.body);
      log(json.encode(lotteriesFound.toJson()));
    });
  }

  getLotterieSoldOut() async {
    var response = await http.get(Uri.parse('$url/getLotterySoldOwn'));
    setState(() {
      lotteriesFound =
          lotteriesIOwnAndOnStoreGetResponseFromJson(response.body);
    });
  }
}
