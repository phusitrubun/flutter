import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _initialDepositController = TextEditingController();

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
                        Row(
                          children: [
                            const Icon(Icons.account_balance_wallet,
                                color: Color(0xFF90191B)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: TextField(
                                controller: _initialDepositController,
                                decoration: InputDecoration(
                                  hintText: 'กำหนดเงินต้น',
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
                        onTap: () {
                          // Handle registration logic
                        },
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
}
