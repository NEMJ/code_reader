import 'package:code_reader/pages/inventory_detail_page.dart';
import 'package:code_reader/widgets/inventory_widget.dart';
import 'package:flutter/material.dart';
import '../data/inventory_data.dart';
import '../models/inventory_model.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  InventoryData inventoryData = InventoryData();
  List<InventoryModel> inventories = [];

  void getInventories() async {
    inventories = await inventoryData.getInventories();
    setState(() {});
  }

  dialogInventoryClosed(BuildContext context) {
    return AlertDialog(
      content: const Text('A coleta não pode mais ser editada', style: TextStyle(fontSize: 18)),
      contentPadding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
      actions: [
        FilledButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  dialogShareInventory(BuildContext context) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInventories();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    inventories.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
            centerTitle: true,
            pinned: true,
            title: Text('Coletas'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList.builder(
            itemCount: inventories.length,
            itemBuilder: (context, index) {
              return InventoryWidget(
                index: index,
                inventory: inventories[index],
                actionButtonOnPressed: (context) {
                  inventoryData.removeInventory(inventories[index].title);
                  getInventories();
                  setState(() {});
                },
                onTap: () { // Se o inventário já tiver sido enviado, ele não pode mais ser editado
                  if (inventories[index].inventoryClosed == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventoryDetailPage(
                          inventory: inventories[index],
                          index: index,
                        ),
                      )
                    ).then((value) => setState(() {})); // atualiza a contagem de códigos do inventário
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => dialogInventoryClosed(context),
                    );
                  }
                }
              );
            },
          ),
        ]
      ),
    );
  }
}