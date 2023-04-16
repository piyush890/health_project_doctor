import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'Brain/MainFuctions.dart';
import 'Brain/Share_Pref.dart';
import 'Load.dart';

class TotalPatient extends StatefulWidget {
  const TotalPatient({super.key});

  @override
  State<TotalPatient> createState() => _TotalPatientState();
}

class _TotalPatientState extends State<TotalPatient> {
    List patientli = [];
           Future<void> From_date() async {
    var datetime = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(1100),
                    lastDate: DateTime(2101));
     setState(() {
  
     String dateo = datetime!.year.toString()+"-"+"0"+datetime.month.toString()+"-"+datetime.day.toString();
     controller.text = dateo;
     });   




 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Container(
                  padding: EdgeInsets.all(10),
                  width: 250,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Search"),
                        suffixIcon: IconButton(
                            onPressed: () => {
                              From_date()
                            }, icon: Icon(Icons.date_range))),
                  )
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(
                                  
                                  
                                  onPressed: () => {
                                  patient()
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Search"),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.black),
                                  ),
                                )
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: patientli.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MaterialButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 115, 67, 245)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                patientli[index]['patient_name'],
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 19),
                              )),
                              SizedBox(width: 50,),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 115, 67, 245)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Verified",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 12),
                              )),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
  TextEditingController controller = new TextEditingController();
   Future<void> patient() async {
 var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final id = await Share_pref().get_depart_id();
       Load().data(context);

      print(controller.text.toString());

    dynamic response = await Brain().getpatientdata(id.toString(), controller.text.toString());
    var data = jsonDecode(response);
     print(data);
      setState(() {
       patientli = data;
      });
     Navigator.pop(context);   
  }
}
