import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class Lab93Screen extends StatefulWidget {
  const Lab93Screen({super.key});

  @override
  State<Lab93Screen> createState() => _Lab93ScreenState();
}

class _Lab93ScreenState extends State<Lab93Screen> {
  final StorageService _storageService = StorageService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _allItems = [];
  List<dynamic> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final items = await _storageService.readProducts();
    setState(() {
      _allItems = items;
      _filteredItems = items;
    });
  }

  Future<void> _saveData() async {
    await _storageService.writeProducts(_allItems);
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              item['description'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showForm(Map<String, dynamic>? item) {
    final nameController = TextEditingController(text: item?['name'] ?? '');
    final priceController = TextEditingController(text: item?['price']?.toString() ?? '');
    final descController = TextEditingController(text: item?['description'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newItem = {
                  'id': item?['id'] ?? DateTime.now().millisecondsSinceEpoch,
                  'name': nameController.text,
                  'price': double.tryParse(priceController.text) ?? 0.0,
                  'description': descController.text,
                };

                setState(() {
                  if (item == null) {
                    _allItems.add(newItem);
                  } else {
                    final index = _allItems.indexWhere((e) => e['id'] == item['id']);
                    _allItems[index] = newItem;
                  }
                  _filterItems(_searchController.text);
                });
                _saveData();
                Navigator.pop(context);
              },
              child: Text(item == null ? 'Add Item' : 'Update Item'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _deleteItem(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _allItems.removeWhere((item) => item['id'] == id);
                _filterItems(_searchController.text);
              });
              _saveData();
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9.3: CRUD & Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search items...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterItems,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']} - ${item['description']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showForm(item)),
                      IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteItem(item['id'])),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
