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

  Future<void> scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancelar",
      true,
      ScanMode.BARCODE,
    );

    setState(() => barcodeController.text = '$barcodeScanRes\n');
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
                  icon: const Icon(Icons.camera_alt_rounded),
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
                  },
                ),
              ),
            ),
            SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return InventoryItemWidget(index: index);
              }
            ),
          ],
        ),
      ),
    );
  }
}