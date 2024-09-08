import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/allLotteryGetResponse.dart';
import 'package:flutter_application_1/models/response/deleteLotteriesAllDeleteResponse.dart';
import 'package:flutter_application_1/models/response/generateLotteriesPostResponse.dart';
import 'package:http/http.dart' as http;

class AddNewLotteryBoard extends StatefulWidget {
  AddNewLotteryBoard({super.key});
  @override
  _AddNewLotteryBoardState createState() => _AddNewLotteryBoardState();
}

class _AddNewLotteryBoardState extends State<AddNewLotteryBoard> {
  final TextEditingController _lotteryNumberController =
      TextEditingController();
  String url = "";
  List<AllLotteryGetResponse> foundDatumLotteries=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      setState(() {
        allLotterryfound();
      });
      
    });
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
                      onPressed: () => RemoveAllLotteries(),
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
                                '1) สามารถสุ่มล็อตเตอรี่ได้เพียงหนึ่งครั้ง ไม่สามารถเพิ่มได้',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Text(
                                '2) ขึ้นกระดานใหม่ต้องล้างล็อตเตอรี่ทั้งหมดก่อนและค่อยสุ่ม',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
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

  Future <void> allLotterryfound() async {
    var lotteriesFound = await http.get(Uri.parse("$url/getAllLottery"));
    setState(() {
       foundDatumLotteries=allLotteryGetResponseFromJson(lotteriesFound.body);
       log(foundDatumLotteries.toString());
    });
  }

  void addNewLotteryNumber() async {
    await allLotterryfound();
    if (foundDatumLotteries.isNotEmpty) {
      showNotAddDialog('มีการสุ่มเลขล็อตเตอรี่มาขายแล้ว');
    } else {
      String input = _lotteryNumberController.text;
      log(input);
      int number = int.parse(input);
      final generrateLotteries =
          await http.post(Uri.parse('$url/GenerateTickets/${number}'));
      GenerateLotteriesPostResponse genLot =
          generateLotteriesPostResponseFromJson(generrateLotteries.body);
      if (genLot.count > 0) {
        showSuccessDialog('สร้างล็อตเตอรี่สำเร็จ ${genLot.count} ใบ');
        allLotterryfound();
      } else {
        showErrorDialog(
            'สร้างไม่สำเร็จเพราะว่ามีล็อตเตอรี่ในฐานข้อมูลอยู่แล้ว');
      }
    }
  }

  void RemoveAllLotteries() async {
   await allLotterryfound();
    if (foundDatumLotteries.isEmpty) {
      showNotDelDialog('ไม่สามารถลบได้ฐานข้อมูล');
    } else {
      final deleteLotteries =
          await http.delete(Uri.parse('$url/deleteAllTicket'));
      log(deleteLotteries.body);
      DeleteLotteriesAllDeleteResponse response =
          deleteLotteriesAllDeleteResponseFromJson(deleteLotteries.body);
      if (response.message == "Delete success  of tickets removed") {
        showSuccessDelDialog('ลบล็อตเตอรี่ทั้งหมดสำเร็จแล้ว');
      } else if (response.message == "No tickets were deleted") {
        showNotDelDialog(
            'ลบไม่สำเร็จเพราะว่าไม่มีล็อตเตอรี่ในฐานข้อมูลอยู่แล้ว');
      }
    }
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('สร้างรายการสำเร็จ'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
        icon: Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.green,
          size: 40,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('สร้างรายการไม่สำเร็จ'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
          size: 40,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ตกลง'),
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showNotAddDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('สร้างรายการไม่สำเร็จ'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
        icon: Icon(Icons.create, color: Colors.red, size: 40),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('ตกลง'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showNotDelDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ลบรายการไม่สำเร็จ'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
        icon: Icon(Icons.delete, color: Colors.red, size: 40),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('ตกลง'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showSuccessDelDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ลบรายการสำเร็จ'),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
        icon: Icon(Icons.delete, color: Colors.green, size: 40),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('ตกลง'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
