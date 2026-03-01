import 'package:flutter/material.dart';

// Hàm main để bạn có thể chạy file này trực tiếp
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InputControlsDemo(),
  ));
}

// 1. Phải sử dụng StatefulWidget vì dữ liệu trên màn hình sẽ thay đổi
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // --- KHAI BÁO CÁC BIẾN LƯU TRỮ TRẠNG THÁI (STATE) ---

  // Biến cho Slider (mặc định là 50)
  double _sliderValue = 50.0;

  // Biến cho Switch (mặc định là tắt - false)
  bool _isSwitched = false;

  // Biến cho RadioListTile (mặc định chưa chọn gì)
  String _selectedGenre = 'None';

  // Biến lưu trữ ngày được chọn từ DatePicker
  DateTime? _selectedDate;

  // Hàm mở DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Ngày mặc định khi mở lên
      firstDate: DateTime(2000),   // Giới hạn ngày nhỏ nhất
      lastDate: DateTime(2101),    // Giới hạn ngày lớn nhất
    );
    // Nếu người dùng có chọn ngày và ngày đó khác ngày hiện tại đang lưu
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // Cập nhật state để UI render lại
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- PHẦN 1: SLIDER ---
          const Text(
            'Rating (Slider)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 100, // Tùy chọn: chia Slider thành 100 bước
            onChanged: (double newValue) {
              // setState giúp báo cho Flutter biết dữ liệu đã đổi, cần vẽ lại màn hình
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          Text('Current value: ${_sliderValue.toInt()}'),
          const SizedBox(height: 24),

          // --- PHẦN 2: SWITCH ---
          const Text(
            'Active (Switch)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('Is movie active?', style: TextStyle(fontSize: 16)),
              ),
              Switch(
                value: _isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- PHẦN 3: RADIOLISTTILE ---
          const Text(
            'Genre (RadioListTile)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Action'),
            value: 'Action', // Giá trị của nút này
            groupValue: _selectedGenre, // So sánh với state hiện tại
            onChanged: (String? value) {
              setState(() {
                _selectedGenre = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Comedy'),
            value: 'Comedy',
            groupValue: _selectedGenre,
            onChanged: (String? value) {
              setState(() {
                _selectedGenre = value!;
              });
            },
          ),
          Text('Selected genre: $_selectedGenre'),
          const SizedBox(height: 24),

          // --- PHẦN 4: DATE PICKER ---
          OutlinedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Open Date Picker'),
          ),
          // Hiển thị ngày đã chọn (nếu có)
          if (_selectedDate != null) ...[
            const SizedBox(height: 8),
            Text(
              'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ]
        ],
      ),
    );
  }
}