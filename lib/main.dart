import 'dart:convert';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_project_doctor/Brain/Share_Pref.dart';
import 'package:health_project_doctor/HomePage.dart';
import 'package:lottie/lottie.dart';

import 'Brain/MainFuctions.dart';
import 'Load.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DoctorLogin(),
  ));
}

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  Color color  = Color.fromARGB(255, 31, 255, 31);


  var ip_address;
   void selfIP()  async { 
    final ipv4 = await Ipify.ipv4();
  setState(() {
    ip_address = ipv4;
  });
}
  Future<void> patient() async {

     if(email.text.toString().isEmpty){
      return;
     }
     
     if(email.text.toString().isEmpty){
      return;
     }

   else{
        Load().data(context);
     dynamic response = await Brain().docLogin(email.text.toString(),password.text.toString(),ip_address);
     var data = jsonDecode(response);
      print(data);
        if (data['status'].toString().contains("0")) {
        var depart_id = data['department'];
        var id = data['id'];  
        var name = data['name'];  
        Share_pref().Set_ID(id.toString(), depart_id.toString(),name.toString());
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
        }
        else{
          Navigator.pop(context);
        }
   }
    
   }
   @override
  void initState() {
    selfIP();
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: LottieBuilder.asset('assets/images/doctor.json')),
            Expanded(
              flex: 2,
              child: 
            Container(
              decoration: BoxDecoration(
              boxShadow: [
                
              ],
                
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text("Doctor Portal",
                    style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.w700,color: Color.fromARGB(255, 110, 110, 110)),),
                  ),
                    SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                     controller: email,
                decoration: InputDecoration(label: Text("Doctor ID",),border: OutlineInputBorder()),),
                ),
                SizedBox(height: 10,),
                Container(
                     padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(label: Text("Password"),border: OutlineInputBorder()),),
                ),
                Container(
                   child: MaterialButton(
                    onPressed: ()=>{
                      patient()
                    },
                    color: Color.fromARGB(255, 3, 247, 35),
                    child: Text("Login",style:GoogleFonts.poppins()),
                    padding: EdgeInsets.all(15),
                    ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 200),
                  width: 190,
                  alignment: Alignment.bottomRight,
                 
                  child: Image.asset('assets/images/leaf.png'),
                ),
                ],
              ),
            )
            )
          ],
        ),
      ),
    );
  }
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}
