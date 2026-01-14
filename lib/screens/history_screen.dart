import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<Map<String, dynamic>>>? _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    _historyFuture = DBHelper.getHistory();
  }

  Future<void> _clearHistory() async {
    await DBHelper.clearHistory();
    setState(() {
      _loadHistory();
    });
  }

  Future<void> _deleteSingle(int id) async {
    final db = await DBHelper.database;
    await db.delete('history', where: 'id = ?', whereArgs: [id]);
    setState(() {
      _loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş İşlemler'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Henüz işlem yapılmadı.'));
          }

          final history = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];

              final transaction =
                  "${item['amount'].toStringAsFixed(2)} ${item['fromCurrency']} ➔ "
                  "${item['result'].toStringAsFixed(2)} ${item['toCurrency']}";

              final date = item['date'];

              return Dismissible(
                key: ValueKey(item['id']),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => _deleteSingle(item['id']),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF2E0219),
                      child: Icon(Icons.history, color: Colors.white),
                    ),
                    title: Text(
                      transaction,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
