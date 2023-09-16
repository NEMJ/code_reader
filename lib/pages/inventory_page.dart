import 'package:flutter/material.dart';
import './inventory_detail_page.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  TextEditingController titleController = TextEditingController();

  navitarionToInventoryDetailPage() {
    if(titleController.text != '') {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InventoryDetailPage(title: titleController.text),
        ),
      ).then((value) {
        titleController.text = '';
      });
    }
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
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Informe o nome do novo inventário"),
            content: TextField(
              onSubmitted: (value) => navitarionToInventoryDetailPage(),
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Ex: Inventário de Janeiro",
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
                onPressed: navitarionToInventoryDetailPage,
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