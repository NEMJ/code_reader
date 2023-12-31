import 'dart:convert';
import 'package:code_reader/models/inventory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const inventoryListKey = 'inventory_list';

class InventoryData {
  late SharedPreferences shared;
  
  Future<List<InventoryModel>> getInventories() async {
    shared = await SharedPreferences.getInstance();

    final String jsonString = shared.getString(inventoryListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List; // transforma a String em uma lista de objetos

    return jsonDecoded.map((e) => InventoryModel.fromJson(e)).toList(); // converte a lista de objetos para uma lista de Inventários e retorna
  }

  Future<bool> containsInventory(String inventoryTitle) async {
    final List<InventoryModel> inventories = await getInventories();
    return inventories.any((inventory) => inventory.title == inventoryTitle);
  }

  // Essa função seria para salvar apenas um inventário à lista de inventários
  void saveInventory(InventoryModel inventory, int? index) async {
    final List<InventoryModel> inventoryList = await getInventories();
    
    if (index == null) {
      int pos = inventoryList.length;
      inventoryList.insert(pos, inventory);
    } else {
      inventoryList.removeAt(index);
      inventoryList.insert(index, inventory);
    }

    final String inventories = jsonEncode(inventoryList);
    shared.setString(inventoryListKey, inventories);
  }

  void removeInventory(String inventory) async {
    final List<InventoryModel> inventoryList = await getInventories();
    var result = inventoryList.indexWhere((e) => e.title == inventory);
    inventoryList.removeAt(result);
    
    final String inventories = jsonEncode(inventoryList);
    shared.setString(inventoryListKey, inventories);
  }
}