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

  // Essa função seria para salvar apenas um inventário à lista de inventários
  void saveInventory(InventoryModel inventory) async {
    final List<InventoryModel> inventoryList = await getInventories();
    inventoryList.add(inventory);

    final String inventories = jsonEncode(inventoryList);
    shared.setString(inventoryListKey, inventories);
    
    // shared.setString(inventoryListKey, jsonString); // Precisa alterar o salvamento para guardar um json contendo o inventário com os códigos
  }

  removeInventory(String index) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.remove(index);
  }
}