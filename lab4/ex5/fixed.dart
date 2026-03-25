import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercise5Screen(),
  ));
}

// FIX 3: Chuyển thành StatefulWidget để dùng được setState()
class Exercise5Screen extends StatefulWidget {
  const Exercise5Screen({super.key});

  @override
  State<Exercise5Screen> createState() => _Exercise5ScreenState();
}

class _Exercise5ScreenState extends State<Exercise5Screen> {
  // Biến dùng để test Fix 3
  int _counter = 0;

  // Biến dùng để test Fix 4
  DateTime? _selectedDate;

  // FIX 4: Hàm gọi DatePicker với context an toàn
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context, // Truyền đúng context của class State hiện tại
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      // FIX 3: Cập nhật giao diện khi chọn ngày xong
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 - Debug & Fix'),
      ),
      // Bố cục chính sử dụng Column
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- TEST FIX 3: Lỗi không cập nhật UI ---
            const Text('Test Fix 3: Thêm setState()', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Số lần bấm: $_counter', style: const TextStyle(fontSize: 16)),
                ElevatedButton(
                  onPressed: () {
                    // FIX 3: Phải có setState thì số mới nhảy
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text('Tăng'),
                ),
              ],
            ),
            const Divider(height: 32),

            // --- TEST FIX 4: Lỗi Context DatePicker ---
            const Text('Test Fix 4: DatePicker Context', style: TextStyle(fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: _pickDate, // Gọi hàm mở DatePicker an toàn
              child: const Text('Chọn Ngày'),
            ),
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Đã chọn: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
              ),
            const Divider(height: 32),

            // --- TEST FIX 1: Lỗi ListView trong Column ---
            const Text('Test Fix 1: ListView inside Column', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // FIX 1: Bọc ListView.builder bằng Expanded để tránh lỗi tràn/không xác định chiều cao
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey.shade100,
                    child: ListTile(
                      leading: const Icon(Icons.movie),
                      title: Text('Movie ${String.fromCharCode(65 + index)}'), // In ra Movie A, B, C, D
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}