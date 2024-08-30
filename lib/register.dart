import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/userRegisterPostResponse.dart';
import 'package:flutter_application_1/models/request/userRegisterPostRequest.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/painting/gradient.dart' as flutter_gradient;
import 'package:giffy_dialog/giffy_dialog.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rive/src/rive_core/shapes/paint/radial_gradient.dart' as rive_gradient;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String url = '';
  // final _initialDepositController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF7A0000),
          image: const DecorationImage(
            image: AssetImage('assets/images/wallpaper_lotto3.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 22.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        // Username Field
                        Row(
                          children: [
                            const Icon(Icons.person, color: Color(0xFF90191B)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'ยูสเซอร์เนม',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Email Field
                        Row(
                          children: [
                            const Icon(Icons.email, color: Color(0xFF90191B)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'อีเมล์',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Password Field
                        Row(
                          children: [
                            const Icon(Icons.lock, color: Color(0xFF90191B)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'รหัสผ่าน',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Initial Deposit Field
                        // Row(
                        //   children: [
                        //     const Icon(Icons.account_balance_wallet,
                        //         color: Color(0xFF90191B)),
                        //     const SizedBox(width: 8.0),
                        //     Expanded(
                        //       child: TextField(
                        //         controller: _initialDepositController,
                        //         decoration: InputDecoration(
                        //           hintText: 'กำหนดเงินต้น',
                        //           border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(8.0),
                        //             borderSide: const BorderSide(
                        //               color: Colors.grey,
                        //               width: 1.0,
                        //             ),
                        //           ),
                        //           filled: true,
                        //           fillColor: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const flutter_gradient.RadialGradient(
                          colors: [
                            Color(0xFFFDFCFF),
                            Color(0xFFE6D9AC),
                            Color(0xFFA49869),
                            Color(0xFF7D6738),
                          ],
                          center: Alignment.center,
                          radius: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () => register(),
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                          width: 200.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person_add,
                                    color: Color(0xFF90191B)),
                                const SizedBox(width: 8.0),
                                const Text(
                                  'สมัครสมาชิก',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF90191B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const flutter_gradient.RadialGradient(
                          colors: [
                            Color(0xFFFDFCFF),
                            Color(0xFFE6D9AC),
                            Color(0xFFA49869),
                            Color(0xFF7D6738),
                          ],
                          center: Alignment.center,
                          radius: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                          width: 160.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: const Text(
                              'เข้าสู่ระบบ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF90191B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  register() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return GiffyDialog.image(
              Image.network(
                "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                height: 200,
                fit: BoxFit.cover,
              ),
              title: Text('ไม่สำเร็จ'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ข้อมูลไม่ครบถ้วน กรุณากรอกให้ครบ'),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('ตกลง'),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    } else {
      UserRegisterPostRequest user = new UserRegisterPostRequest(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      final response = await http.post(
        Uri.parse("$url/register"),
        headers: {"Content-Type": "application/json"},
        body: userRegisterPostRequestToJson(user),
      );
      log(response.body);
      UserRegisterPostResponse responseUser =
          userRegisterPostResponseFromJson(response.body);
      log(responseUser.toString());
      if (responseUser.message == "register success 1") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return GiffyDialog.lottie(
                Lottie.network(
                  "https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json",
                  fit: BoxFit.contain,
                  height: 200,
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'สำเร็จ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('สมัครสมาชิกสำเร็จ'),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green, 
                      foregroundColor: Colors.white),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('ตกลง'),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } else if (responseUser.message == " มี email นี้แล้ว") {
        showDialog(
            context: context,
            builder: (BuildContext builder) {
              return GiffyDialog.rive(
                RiveAnimation.network(
                  "https://cdn.rive.app/animations/vehicles.riv",
                  fit: BoxFit.cover,
                  placeHolder: Center(child: CircularProgressIndicator()),
                ),
                title: Text(
                  'ไม่สำเร็จ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // icon: Icon(
                //   Icons.error_outline_outlined,
                //   color: Colors.red,
                //   size: 50,
                // ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('อีเมล์นี้มีผู้ใช้แล้ว กรุณาสร้างอีเมล์ใหม่'),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red, 
                      foregroundColor: Colors.white),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('ตกลง'),
                            ],
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      } else if (responseUser.message == " มี username นี้แล้ว") {
        showDialog(
            context: context,
            builder: (BuildContext builder) {
              return GiffyDialog.rive(
                RiveAnimation.network(
                  "https://cdn.rive.app/animations/vehicles.riv",
                  fit: BoxFit.cover,
                  placeHolder: Center(child: CircularProgressIndicator()),
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ไม่สำเร็จ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ชื่อผู้ใช้นี้ถูกแล้ว กรุณากรอกชื่อใหม่'),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                          child: Text('ตกลง'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white)),
                    ],
                  )
                ],
              );
            });
      }
    }
  }
}
