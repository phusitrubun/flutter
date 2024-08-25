import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
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
                      onPressed: () {
                        // Action for "ลอตโต้ที่เหลือ"
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
                        'ลอตโต้ที่เหลือ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Action for "ขายแล้ว"
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
                        'ขายแล้ว',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Lottery number list
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[900]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: const Color(0xFFFFD700), width: 2),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
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
                                  'lotto ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  generateRandomNumber(),
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
                ),
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

  String generateRandomNumber() {
    // Generates a 7-digit number as a string to match the image
    return (1000000 +
            (9999999 - 1000000) *
                (DateTime.now().microsecondsSinceEpoch % 10000000) ~/
                10000000)
        .toString();
  }
}

void main() => runApp(const MaterialApp(home: Admin()));
