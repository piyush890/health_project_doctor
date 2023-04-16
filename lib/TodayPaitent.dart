import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_project_doctor/Brain/Share_Pref.dart';
import 'package:intl/intl.dart';

import 'Brain/MainFuctions.dart';
import 'Load.dart';


class TodayPaitent extends StatefulWidget {
  const TodayPaitent({super.key});

  @override
  State<TodayPaitent> createState() => _TodayPaitentState();
}

class _TodayPaitentState extends State<TodayPaitent> {

  List patientli = [];

  Future<void> patient() async {
 var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    final id = await Share_pref().get_depart_id();
       Load().data(context);

    dynamic response = await Brain().getpatientdata(id.toString(), formattedDate);
    var data = jsonDecode(response);
     print(data);
      setState(() {
        patientli = data;
      });
     Navigator.pop(context);   
  }
  @override
  void initState() {
    patient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
              padding: EdgeInsets.all(10),
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Search"),
                    suffixIcon: IconButton(
                        onPressed: () => {}, icon: Icon(Icons.search_rounded))),
              )),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: patientli.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String verfiy = patientli[index]['scanned'];
              String n = '';
              if (verfiy.contains("0")) {
                n = "Verified";
              }
              else{
                n = "Not Verified";
              }
              return MaterialButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  print(index);
                },
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 115, 67, 245)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                patientli[index]['patient_name'],
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 19),
                              )),
                          Container(
                            alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 115, 67, 245)),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                n,
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 12),
                              )),
                          Container(
                            child: Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () => {
                                    setState(() {
                                     patientli.removeAt(index);
                                    },)
                                   },
                                  child: Icon(Icons.done),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.black),
                                  ),
                                ),
                               
                              ],
                            ),
                          )
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
}
