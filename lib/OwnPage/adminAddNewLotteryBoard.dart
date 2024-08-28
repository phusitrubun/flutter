import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/OwnPage/admin.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/lotteriesOwnAndOnStoreGetResponse.dart';

import 'package:http/http.dart' as http;

class AddNewLotteryBoard extends StatefulWidget {
  int idx = 0;
  AddNewLotteryBoard({super.key, required this.idx});
  @override
  _AddNewLotteryBoardState createState() => _AddNewLotteryBoardState();
}

class _AddNewLotteryBoardState extends State<AddNewLotteryBoard> {
  final TextEditingController _lotteryNumberController =
      TextEditingController();
  String url = "";
  int _selectedIndex = 1;
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
                TextField(
                  controller: _lotteryNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  decoration: InputDecoration(
                    labelText: 'กรุณากรอกจำนวนใบล็อตเตอรี่',
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.yellow, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      int enteredValue = int.tryParse(value) ?? 0;
                      if (enteredValue > 300) {
                        _lotteryNumberController.text = '300';
                        _lotteryNumberController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: _lotteryNumberController.text.length),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_lotteryNumberController.text.isNotEmpty) {
                          addNewLotteryNumber();
                        } else {
                          showErrorDialog('กรุณากรอกหมายเลขลอตเตอรี่');
                        }
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
                        'สุ่มล็อตเตอรี่',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_lotteryNumberController.text.isNotEmpty) {
                          addNewLotteryNumber();
                        } else {
                          showErrorDialog('กรุณากรอกหมายเลขลอตเตอรี่');
                        }
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
                        'ล้างล็อตเตอรี่ทั้งหมด',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    // width: 300, // กำหนดขนาดของ SizedBox
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 193, 26, 26),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          children: [
                            Icon(
                              Icons.local_activity_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'สามารถ สุ่ม lotterie ได้มากสุดที่ 300 ใบ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: SizedBox(
                    // width: 300, // กำหนดขนาดของ SizedBox
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 193, 26, 26),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'วิธีใช้',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                                '1) สามารถสุ่มล็อตเตอรี่ได้เพียงหนึ่งครั้ง ไม่สามารถเพิ่มได้',style: TextStyle(color: Colors.white, fontSize: 18)),
                            Text(
                                '2) ขึ้นกระดานใหม่ต้องล้างล็อตเตอรี่ทั้งหมดก่อนและค่อยสุ่ม',style: TextStyle(color: Colors.white, fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addNewLotteryNumber() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];
    final foundDatumLotteries = await http.get(Uri.parse("$url/getAllLottery"));
    if (foundDatumLotteries != null) {
      showNotAddDialog(
          'มีการสุ่มเลขล็อตเตอรี่มาขายแล้ว กรุณาลบล็อตเตอรี่ทั้งหมด เพื่อสร้างกระดานเลขใหม่');
    } else {
      final generrateLotteries = await http.post(
        Uri.parse('$url/GennerateTickets'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'numberOfTickets': _lotteryNumberController.text}),
      );
      if (generrateLotteries.statusCode == 200) {
        showSuccessDialog('บันทึกสำเร็จ');
      } else {
        showErrorDialog('บันทึกไม่สำเร็จ');
      }
    }
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('สำเร็จ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ผิดพลาด'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  void showNotAddDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ผิดพลาด'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }
}
