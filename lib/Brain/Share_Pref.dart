import 'package:shared_preferences/shared_preferences.dart';

class Share_pref{
  Future<void> Set_ID(String ID,String department_id,name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('doctor_id',ID);
    prefs.setString('department_id',department_id);
    prefs.setString('name',name);
  }
 
  Future<String> get_id() async {
    final prefs = await SharedPreferences.getInstance();
   String? id =  prefs.getString('doctor_id');
    return id.toString();
  }
  Future<String> get_depart_id() async {
    final prefs = await SharedPreferences.getInstance();
   String? com_id =  prefs.getString('department_id');
    return com_id.toString();
  }
  Future<String> get_depart_name() async {
    final prefs = await SharedPreferences.getInstance();
   String? com_id =  prefs.getString('name');
    return com_id.toString();
  }
}