import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  List<String> datas = [];
  savedata() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setStringList('dataList', datas);
    notifyListeners();
  }

  getdata() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    datas = sharedpref.getStringList('dataList')??[];
    notifyListeners();
  }

  adddata(String data) {
    datas.add(data);
    savedata();
    nameController.clear();
    notifyListeners();
  }
  deleteData(int index)async{
    datas.removeAt(index);
    savedata();
    notifyListeners();
  }
    updateData(String data, [int? index]) {
    if (index != null && index >= 0 && index < datas.length) {
      datas[index] = data;
    } else {
      datas.add(data);
    }
    savedata();
    nameController.clear();
    notifyListeners();
  }
}
