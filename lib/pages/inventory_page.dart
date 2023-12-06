import 'package:flutter/material.dart';
import '../data/inventory_data.dart';
import './inventory_detail_page.dart';
import '../models/inventory_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  TextEditingController titleController = TextEditingController();
  late List<InventoryModel> listInventories;
  InventoryData inventoryData = InventoryData();

  getInventories() async {
    listInventories = await inventoryData.getInventories();
  }

  navigationToInventoryDetailPage() {
    if(titleController.text != '') {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InventoryDetailPage(
            inventory: InventoryModel(title: titleController.text, codes: []),
          ),
        ),
      ).then((value) {
        titleController.text = '';
      });
    }
  }

  onCreateInventory() {
    if (listInventories.any((inv) => inv.title == titleController.text)) {
      Navigator.of(context).pop();
      titleController.text = "";

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Este nome de coleta já existe!"),
        ),
      );
    } else {
      navigationToInventoryDetailPage();
    }
  }

  @override
  void initState() {
    super.initState();
    getInventories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/JRTi_Logo.png'),
          const Text(
            "Vamos cadastrar uma nova coleta?",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Informe o nome da nova coleta"),
            content: TextField(
              onSubmitted: (value) => onCreateInventory(),
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Ex: Coleta de Janeiro",
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white70,
                filled: true,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  backgroundColor: Colors.blueGrey[100],
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: onCreateInventory,
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