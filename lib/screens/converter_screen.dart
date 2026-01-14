import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'USD';
  String _toCurrency = 'TRY';

  double _result = 0.0;
  bool _hasCalculated = false;

  final Map<String, double> _rates = {
    'USD': 1.0,
    'TRY': 43.14,
    'EUR': 0.86,
    'GBP': 0.75,
    'JPY': 157.39,
  };

  Future<void> _executeTransformation() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final calculatedResult =
        (amount / _rates[_fromCurrency]!) * _rates[_toCurrency]!;

    final now = DateTime.now();
    final formattedDate =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')}";

    setState(() {
      _result = calculatedResult;
      _hasCalculated = true;
    });

    await DBHelper.insertHistory(
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      amount: amount,
      result: calculatedResult,
      date: formattedDate,
    );

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DÖVİZMATİK'), centerTitle: true),
      body: Column(
        children: [
          _buildTopPanel(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Miktar ve Birim",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2E0219),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Miktar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCurrencySelectors(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _executeTransformation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E0219),
                        foregroundColor: const Color(0xFFC0C0C0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "HESAPLA",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_hasCalculated) _buildResultCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPanel() {
    final currencies = _rates.keys.where((k) => k != 'USD').toList();

    return Container(
      height: 100,
      color: const Color(0xFF2E0219).withOpacity(0.05),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: currencies
            .map((k) => _topInfoCard(k, '${_rates[k]} $k'))
            .toList(),
      ),
    );
  }

  Widget _topInfoCard(String currency, String value) {
    return Container(
      width: 110,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC0C0C0), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '1 USD',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E0219),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E0219), Color(0xFF4A0E2E)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Karşılığı',
            style: TextStyle(color: Color(0xFFC0C0C0), fontSize: 14),
          ),
          Text(
            '${_result.toStringAsFixed(2)} $_toCurrency',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySelectors() {
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(
            _fromCurrency,
            (v) => setState(() => _fromCurrency = v!),
          ),
        ),
        const Icon(Icons.swap_horiz, color: Color(0xFFC0C0C0), size: 30),
        Expanded(
          child: _buildDropdown(
            _toCurrency,
            (v) => setState(() => _toCurrency = v!),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: _rates.keys
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
