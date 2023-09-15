import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  String barcodeScanRes = '';

  Future<void> scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.BARCODE,
    );

    setState(() => barcodeScanRes);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/barcode.png'),
              const Text(
                "Vamos criar um novo inventário?",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: scanBarcode,
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Informe o nome do novo inventário"),
            content: const TextField(
              decoration: InputDecoration(
                hintText: "Ex: Inventário de Janeiro",
                border: InputBorder.none,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  backgroundColor: Colors.blueGrey[100],
                ),
                onPressed: () {},
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: () {},
                child: const Text("Confirmar"),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}