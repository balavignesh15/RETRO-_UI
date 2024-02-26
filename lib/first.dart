import 'package:flutter/material.dart';

class exppage extends StatefulWidget {
  const exppage({super.key});

  @override
  State<exppage> createState() => _exppageState();
}

class _exppageState extends State<exppage> {

  TextEditingController cnt= TextEditingController();

  void _addItemToList() {
    String text = cnt.text;
    if (text.isNotEmpty) {
      setState(() {
        var items = {
          "ABCD": text,
        };
        Navigator.pop(context, [items]); // Return the list of items
      });
    }
  }
  String text1="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text("Expense Category",style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Category",style: TextStyle(
                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    fontSize: 24,
                    color: Colors.black
                ),),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 80,
                    width: 180,
                    child: TextFormField(
                      controller: cnt,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter your Expense",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                  ),
                  onPressed: (){
                    setState(() {
                      _addItemToList();
                    });
                  },
                  child: Text("Save",style: TextStyle(fontWeight: FontWeight.w100,
                      color: Colors.white,fontFamily: "Outfit"
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
