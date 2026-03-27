import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Ẩn chữ debug góc phải
    home: CoreWidgetsDemo(), // Gọi màn hình của bạn ra
  ));
}
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets'),
      ),
      // Sử dụng ListView để tránh lỗi tràn màn hình nếu nội dung quá dài
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. A headline Text
          const Text(
            'Welcome to Flutter UI',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // 2. An Icon using Material Icons
          const Icon(
            Icons.movie, // Icon cuộn phim giống trong ảnh mẫu
            size: 80,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),

          // 3. An Image.network()
          // Sử dụng một ảnh phong cảnh từ Unsplash làm ví dụ
          Image.network(
            'images/810611-lqjaytrzto-1466843799.png',
            height: 200,
            fit: BoxFit.cover, // Giúp ảnh lấp đầy khung hình mà không bị méo
            // Thêm loading builder để hiển thị icon chờ khi ảnh đang tải (tùy chọn thêm cho đẹp)
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const SizedBox(height: 20),

          // 4. A Card containing a ListTile
          const Card(
            elevation: 4, // Tạo độ đổ bóng cho Card
            child: ListTile(
              leading: Icon(
                Icons.star,
                size: 32,
                color: Colors.black54,
              ),
              title: Text(
                'Movie Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('This is a sample ListTile inside a Card.'),
            ),
          ),
        ],
      ),
    );
  }
}