import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lab91Screen extends StatefulWidget {
  const Lab91Screen({super.key});

  @override
  State<Lab91Screen> createState() => _Lab91ScreenState();
}

class _Lab91ScreenState extends State<Lab91Screen> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final data = await json.decode(response);
    setState(() {
      _products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9.1: Read JSON Assets')),
      body: _products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final item = _products[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']} - ${item['description']}'),
                  leading: CircleAvatar(child: Text(item['id'].toString())),
                );
              },
            ),
    );
  }
}
