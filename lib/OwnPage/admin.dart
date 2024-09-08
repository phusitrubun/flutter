import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/OwnPage/adminAddNewLotteryBoard.dart';
import 'package:flutter_application_1/OwnPage/adminPrizeAward.dart';
import 'package:flutter_application_1/OwnPage/adminShowLotteries.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/models/response/lotteriesOwnAndOnStoreGetResponse.dart';
import 'package:flutter_application_1/shared/appData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  Admin({super.key});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;
  String url = "";
  late LotteriesIOwnAndOnStoreGetResponse lotteriesFound;
  late Future<void> loadData;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // loadData = getLotteryOnStore();

    _pages.add(AdminShowLotterie());
    _pages.add(AddNewLotteryBoard());
    _pages.add(AdminPrizeAwardPage());
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
              setState(() {
                context.read<AppData>().idx = 0;
                log(context.read<AppData>().idx.toString());
              });
              Get.offAll(() => LoginPage());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // IndexedStack(
      //   index: _selectedIndex,
      //   children: _pages,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF7A0000),
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
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
    log(context.read<AppData>().idx.toString());
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
