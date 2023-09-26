import 'package:code_reader/data/inventory_data.dart';
import 'package:code_reader/models/inventory_model.dart';
import 'package:code_reader/widgets/inventory_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class InventoryDetailPage extends StatefulWidget {
  const InventoryDetailPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<InventoryDetailPage> createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  
  String barcodeScanRes = '';
  late FocusNode focusNode;
  late TextEditingController barcodeController;
  List<String> codes = [];
  late InventoryData inventoryData = InventoryData();
  late List<InventoryModel> inventoriesList;

  Future<void> scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.BARCODE,
    );
    
    addCodeOnInventory(barcodeScanRes);
  }

  addCodeOnInventory(String code) {
    if(code != "-1") {
      setState(() => codes.add(code));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    focusNode = FocusNode();
    barcodeController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    barcodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Retira o foco do TextField ao clicar em qualquer lugar da tela
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              centerTitle: true,
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: scanBarcode,
                  icon: const Icon(Icons.camera_alt),
                ),
                IconButton(
                  // onPressed: () => inventoryData.saveInventory(widget.title, codes), // A lista de códigos é salva no dispositivo
                  onPressed: () => inventoryData.saveInventory(
                    InventoryModel(
                      title: widget.title,
                      codes: codes,
                    ),
                  ),
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  autofocus: true,
                  focusNode: focusNode, // Parâmetro que controla o foco do TextField
                  controller: barcodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    barcodeController.text = '';
                    FocusScope.of(context).requestFocus(focusNode); // Faz retornar o foco para o campo de texto
                    addCodeOnInventory(value);
                  },
                ),
              ),
            ),
            SliverList.builder(
              itemCount: codes.length,
              itemBuilder: (context, index) {
                return InventoryItemWidget(
                  code: codes[index],
                  onPressed: () => setState(() => codes.removeAt(index)), // Função responsável pelo botão de ação do item
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}