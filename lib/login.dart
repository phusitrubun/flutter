import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/OwnPage/admin.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/request/userLoginPostRequest.dart';
import 'package:flutter_application_1/models/response/userLoginPostReaponse.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/reward.dart';
import 'package:flutter_application_1/shared/appData.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String url = '';
  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then(
      (config) {
        url = config['apiEndpoint'];
      },
    );
    context.read<AppData>().idx=0;
    log(context.read<AppData>().idx.toString());
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF7A0000),
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper_lotto3.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'เข้าสู่ระบบ',
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
                      Row(
                        children: [
                          const Icon(Icons.email, color: Color(0xFF90191B)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                hintText: 'ชื่อผู้ใช้',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
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
                      Row(
                        children: [
                          const Icon(Icons.lock, color: Color(0xFF90191B)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'รหัสผ่าน',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
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
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
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
                      onTap: () => loginProcess(
                          context, _usernameController, _passwordController),
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        width:
                            160.0, // Set the width to keep the button size consistent
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
                const SizedBox(height: 16.0),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        width: 200.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add, color: Color(0xFF90191B)),
                              SizedBox(width: 8.0),
                              Text(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginProcess(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController) async {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(); // Close dialog after 2 seconds
            });

            return AlertDialog(
              title: Text(
                "เข้าสู่ระบบไม่สำเร็จ",
                style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(
                Icons.error_outline_outlined,
                color: Colors.red[800],
                size: 70,
              ),
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("โปรดกรอกข้อมูลให้ครบถ้วน"),
                ],
              ),
            );
          });
      return; // Exit the function if fields are empty
    }

    UserLoginPostReqest reqLogin = UserLoginPostReqest(
      email: email,
      password: password,
    );

    try {
      final response = await http.post(
        Uri.parse("$url/login"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: userLoginPostReqestToJson(reqLogin),
      );

      log(response.body);
      UserLoginPostResponse responseLogin =
          userLoginPostResponseFromJson(response.body);

      if (responseLogin != null &&
          responseLogin.message == "login successful") {
            setState(() {
              context.read<AppData>().idx=responseLogin.user.uid;
            });
        if (responseLogin.user.tid == 2) {
          log(responseLogin.user.username);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPage(idx: responseLogin.user.uid),
                  ),
                );
              });

              return AlertDialog(
                title: Text(
                  "เข้าสู่ระบบสำเร็จ",
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green[800],
                  size: 70,
                ),
              );
            },
          );
        } else if (responseLogin.user.tid == 1) {
          log(responseLogin.user.username);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 2), () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Admin(),
                  ),
                );
              });

              return AlertDialog(
                title: Text(
                  "เข้าสู่ระบบสำเร็จ",
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green[800],
                  size: 70,
                ),
              );
            },
          );
        }
      }
    } catch (error) {
      log("Error: $error");
      showErrorDialog(
          context, "เข้าสู่ระบบไม่สำเร็จ", "อีเมลหรือรหัสผ่านไม่ถูกต้อง");
    }
  }

  void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.red[800],
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(
            Icons.error_outline_outlined,
            color: Colors.red[800],
            size: 70,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content),
            ],
          ),
        );
      },
    );
  }
}
