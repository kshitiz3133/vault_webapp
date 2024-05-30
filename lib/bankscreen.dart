import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Util/bankinfo.dart';
import 'Util/baseurl.dart';
import 'bankpin.dart';

class BankList extends StatefulWidget {
  const BankList({Key? key}) : super(key: key);

  @override
  State<BankList> createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  List<Map<String, dynamic>> getUnlinkedBanks() {
    return banks.where((bank) => bank['status'] == 'unlinked').toList();
  }

  List<Map<String, dynamic>> getlinkedBanks() {
    return banks.where((bank) => bank['status'] == 'linked').toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> unlinkedBanks = getUnlinkedBanks();
    List<Map<String, dynamic>> linkedBanks = getlinkedBanks();

    return Scaffold(
      appBar: AppBar(
        title: Text("Banks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Authorised Banks",
                style: TextStyle(fontSize: 30),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: linkedBanks.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const BankPIN(),transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    final tween = Tween(begin: begin, end: end);
                                    final offsetAnimation = animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },));
                                  print("hi");
                                },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        linkedBanks[index]["name"],
                                      ),
                                      SizedBox(width: 150,),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Unlink")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        Divider(),
                      ],
                    );
                  }),
              Text(
                "Unauthorised Banks",
                style: TextStyle(fontSize: 30),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: unlinkedBanks.length,
                  itemBuilder: (context, index) {
                    var _overlaycontroller = OverlayPortalController();
                    return Column(
                      children: [
                        Container(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                                child: OverlayPortal(
                                  controller: _overlaycontroller,
                                  overlayChildBuilder: (BuildContext context) {
                                    return Stack(
                                      children: [
                                        Center(
                                            child: AnimatedNotice(
                                              onClose: () {
                                                _overlaycontroller.toggle(); // Close the overlay portal
                                              },
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Text(
                                    unlinkedBanks[index]["name"],
                                  ),
                                  SizedBox(width: 150,),
                                  ElevatedButton(
                                      onPressed: () {
                                        _overlaycontroller.toggle();
                                      }, child: Text("Link"))
                                ],
                              ),),
                            )),
                        Divider(),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}




class AnimatedNotice extends StatefulWidget {
  final VoidCallback onClose;

  const AnimatedNotice({required this.onClose});
  @override
  _AnimatedNoticeState createState() => _AnimatedNoticeState();
}

class _AnimatedNoticeState extends State<AnimatedNotice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool flag=true;
  bool flaga=true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100), // Set your desired duration
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(_controller);

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: Transform.translate(
        offset: Offset(0, 25),
        child:
            flag?
        Container(
          height: 525,
          width: 338,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Text("Login",style: TextStyle(color: Colors.black,fontSize: 30),),
                Container(width: 280,child: Column(children: [
                  TextField(decoration:
                  InputDecoration(labelText: 'Phone Number'),style: TextStyle(color: Colors.black),),
                  TextField(decoration:
                  InputDecoration(labelText: 'Password'),style: TextStyle(color: Colors.black),)
                ],),),
                SizedBox(height: 50,),
                ElevatedButton(onPressed: (){bankloginload();}, child: Text("Submit")),
                SizedBox(height: 30,),
                GestureDetector(onTap: (){_controller.reverse();Future.delayed(Duration(milliseconds: 100),(){
                  widget.onClose();
                });},child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 20),),
                )),
              ],
            ),
          )),
        ):
                flaga?
            Container(
              height: 525,
              width: 338,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Text("OTP",style: TextStyle(color: Colors.black,fontSize: 30),),
                    Container(width: 150,child: Column(children: [
                      TextField(
                        textAlign: TextAlign.center,
                        decoration:
                      InputDecoration(labelText: 'Enter OTP'),style: TextStyle(color: Colors.black),),
                    ],),),
                    SizedBox(height: 50,),
                    ElevatedButton(onPressed: (){print("Submit");bankOTP();}, child: Text("Submit")),
                    SizedBox(height: 30,),
                    GestureDetector(onTap: (){_controller.reverse();Future.delayed(Duration(milliseconds: 100),(){
                      widget.onClose();
                    });},child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 20),),
                    )),
                  ],
                ),
              )),
            ):Container(
                  height: 525,
                  width: 338,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Text("Set PIN for this Bank",style: TextStyle(color: Colors.black,fontSize: 30),),
                        Container(width: 150,child: Column(children: [
                          TextField(
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            decoration:
                            InputDecoration(labelText: 'Enter PIN'),style: TextStyle(color: Colors.black),),
                        ],),),
                        SizedBox(height: 50,),
                        ElevatedButton(onPressed: (){print("Submit");}, child: Text("Submit")),
                        SizedBox(height: 30,),
                        GestureDetector(onTap: (){_controller.reverse();Future.delayed(Duration(milliseconds: 100),(){
                          widget.onClose();
                        });},child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 20),),
                        )),
                      ],
                    ),
                  )),
                ),
      ),
    );
  }

  Future<void> banklogin() async {
    var url = Uri.parse('${BaseUrl.baseUrl}/auth/verifyotp');
    var body = json.encode({

    });

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 401) {
      setState(() {
        flag=false;
      });
    }
    print('Response body: ${response.body}');
  }
  Future<void> bankotplogin() async {
    var url = Uri.parse('${BaseUrl.baseUrl}/auth/verifyotp');
    var body = json.encode({

    });

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 401) {
      setState(() {
        flaga=false;
      });
    }
    print('Response body: ${response.body}');
  }

  Future<void> bankloginload() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await banklogin();
    Navigator.of(context).pop();
  }
  Future<void> bankOTP() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await bankotplogin();
    Navigator.of(context).pop();
  }
}
