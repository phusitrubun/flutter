import 'package:flutter/material.dart';
import 'package:flutter_application_1/OwnPage/adminAddNewLotteryBoard.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/shared/appData.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class Mainlotto extends StatelessWidget {
  const Mainlotto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color:  Color(0xFF7A0000),
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_lotto3.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Stack(
          children: [
            // เนื้อหาหลัก
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo_lotto.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'จ่ายเร็ว จ่ายง่าย เลขปัง',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          // นำผู้ใช้ไปยังหน้า Login
                          if(context.read<AppData>().idx<=0){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                          }
                          else{
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          );
                          }
                          
                        },
                        child: const Text(
                          'start ›',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
