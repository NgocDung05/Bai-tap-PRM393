import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LayoutDemo(),
  ));
}

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  // Tạo một danh sách dữ liệu mẫu (các bộ phim)
  final List<Map<String, String>> movies = const [
    {'title': 'Avatar', 'description': 'Sample description'},
    {'title': 'Inception', 'description': 'Sample description'},
    {'title': 'Interstellar', 'description': 'Sample description'},
    {'title': 'Joker', 'description': 'Sample description'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      // 1. Bao bọc toàn bộ nội dung bằng Padding để có khoảng cách với mép màn hình (16px)
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 2. Sử dụng Column để xếp các phần tử từ trên xuống dưới
        child: Column(
          children: [
            // --- PHẦN HEADER ---
            const Text(
              'Now Playing',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Dùng SizedBox tạo khoảng cách giữa tiêu đề và danh sách (16px)
            const SizedBox(height: 16),

            // --- PHẦN DANH SÁCH CUỘN ---
            // QUAN TRỌNG: Khi đặt ListView bên trong Column, BẮT BUỘC phải bọc bằng Expanded
            // Nếu không có Expanded, Flutter sẽ báo lỗi không xác định được chiều cao của danh sách.
            Expanded(
              // 3. Sử dụng ListView.builder để tạo danh sách động
              child: ListView.builder(
                itemCount: movies.length, // Số lượng phần tử trong danh sách
                itemBuilder: (context, index) {
                  final movie = movies[index]; // Lấy dữ liệu của phim hiện tại

                  return Card(
                    elevation: 0, // Xóa đổ bóng để giống hình mẫu
                    color: Colors.grey.shade100, // Màu nền xám nhạt
                    margin: const EdgeInsets.only(bottom: 12), // Khoảng cách giữa các thẻ (12px) [cite: 41]
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      // CircleAvatar tạo hình tròn chứa chữ cái đầu của tên phim
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        foregroundColor: Colors.indigo.shade900,
                        child: Text(movie['title']![0]),
                      ),
                      title: Text(movie['title']!),
                      subtitle: Text(movie['description']!),
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