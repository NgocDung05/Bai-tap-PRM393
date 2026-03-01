import 'package:flutter/material.dart';

void main() {
  runApp(const Exercise4App());
}

// 1. Phải dùng StatefulWidget ở ngoài cùng để quản lý trạng thái Sáng/Tối cho toàn App
class Exercise4App extends StatefulWidget {
  const Exercise4App({super.key});

  @override
  State<Exercise4App> createState() => _Exercise4AppState();
}

class _Exercise4AppState extends State<Exercise4App> {
  // Biến lưu trạng thái theme hiện tại (mặc định là sáng)
  ThemeMode _themeMode = ThemeMode.light;

  // Hàm chuyển đổi theme khi người dùng gạt Switch
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Cấu hình Theme sáng
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Cấu hình Theme tối
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      // Báo cho MaterialApp biết đang dùng Theme nào
      themeMode: _themeMode,

      // Truyền trạng thái hiện tại và hàm chuyển đổi vào màn hình chính
      home: AppStructureScreen(
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

// 2. Màn hình chính sử dụng Scaffold
class AppStructureScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const AppStructureScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar có chứa công tắc
      appBar: AppBar(
        title: const Text('Exercise 4 – App Structure'),
        actions: [
          Row(
            children: [
              const Text('Dark'),
              Switch(
                value: isDarkMode,
                onChanged: onThemeChanged,
              ),
              const SizedBox(width: 16), // Tạo khoảng cách với mép phải
            ],
          )
        ],
      ),
      // Body hiển thị câu text đơn giản giống hình mẫu
      body: const Center(
        child: Text(
          'This is a simple screen with theme toggle.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      // Nút nổi FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Hiển thị thông báo nhỏ khi bấm
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Floating Action Button clicked!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}