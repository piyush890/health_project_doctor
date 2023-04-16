import 'dart:convert';

import 'package:http/http.dart' as http;

import 'BaseURL.dart';
class Brain{
    Future<String> getpatientdata(id,date) async {
    dynamic response;
    response = await http.post(
         Uri.parse(BaseUrl.getPatientdata),
         body: jsonEncode(
          {
          "department_id":id,
          "date":date
           }
         
         )
        );

        String res = response.body;
        
    return res;
  }
    Future<String> docLogin(email,password,ip) async {
    dynamic response;
    response = await http.post(
         Uri.parse(BaseUrl.docLogin),
         body: jsonEncode(
          {
            "email":email,
           "password":password,
           "key":"DES!K!@F(ILES<@>::{}/////FILESNULLVA:L",
           "ip_address":ip

          }
         
         )
        );

        String res = response.body;
        
    return res;
  }
   
}