import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_project_doctor/TodayPaitent.dart';
import 'package:health_project_doctor/TotalPatient.dart';

import 'Brain/Share_Pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  int pageChanged= 0;
  String name = '';
  Future<void> doc_Name() async {
        final id = await Share_pref().get_depart_name();
        setState(() {
          name = id.toString();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                         
                            alignment: Alignment.centerLeft,
                            child: Text("Hello",style: GoogleFonts.poppins(fontSize: 18,color: Color.fromARGB(137, 49, 49, 49)),textAlign: TextAlign.start,)),
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(name,style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),))
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),
                     MaterialButton(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        hoverColor: Color.fromARGB(255, 1, 0, 75),
                        onPressed: (() {
                          
                        }),
                          color: Color.fromARGB(255, 0, 26, 255),

                        child: Row(
                          children: [
                            Icon(Icons.home,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Home Page",style: GoogleFonts.poppins(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    SizedBox(height: 12,),
                     MaterialButton(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        hoverColor: Color.fromARGB(255, 1, 0, 75),
                        onPressed: (() {
                          controller.animateToPage(--pageChanged,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);
                        }),
                          color: Color.fromARGB(255, 0, 26, 255),

                        child: Row(
                          children: [
                            Icon(Icons.health_and_safety_outlined,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Today's Patient",style: GoogleFonts.poppins(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    SizedBox(height: 12,),
                     MaterialButton(
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(20),
                        hoverColor: Color.fromARGB(255, 1, 0, 75),
                        onPressed: (() {
                            controller.animateToPage(++pageChanged,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);
                        }),
                          color: Color.fromARGB(255, 0, 26, 255),

                        child: Row(
                          children: [
                            Icon(Icons.health_and_safety_outlined,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Total Patient",style: GoogleFonts.poppins(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    
                  ],
                 ),
               ),
            )),
            SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Container(
              child: PageView(
                onPageChanged: (index) {
                      pageChanged = index;
                   },
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: TodayPaitent(),
                  ),
                   Container(
                     child: TotalPatient(),
                   )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}