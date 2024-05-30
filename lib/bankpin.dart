import 'package:vault_webapp/vault.dart';
import 'package:flutter/material.dart';

class BankPIN extends StatefulWidget {
  const BankPIN({Key? key}) : super(key: key);

  @override
  State<BankPIN> createState() => _BankPINState();
}

class _BankPINState extends State<BankPIN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PIN"),),
      body: Padding(
      padding: const EdgeInsets.all(48.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                  width: 200,
                  child: TextField(
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  )
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VaultHome()));
              }, child: Text("Enter PIN"))

            ],
          ),
        ),
      ),
    ),);
  }
}
