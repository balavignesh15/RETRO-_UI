import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first.dart';

class showcat extends StatefulWidget {
  const showcat({super.key});

  @override
  State<showcat> createState() => _showcatState();
}

class _showcatState extends State<showcat> {
  List<Map<String, String>> ca7tegory = [];
  String name="";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('category') ?? '[]';
    setState(() {
      category = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (items) => Map<String, String>.from(items),
        ),
      );
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('category', json.encode(category));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        actions: [
          ElevatedButton(onPressed: ()async{
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => exppage()),
            );

            // Update dataList with the returned data
            if (result != null) {
              setState(() {
                category.add(result);
                saveData();
              });
            }

          }, child: Text("Add")),
        ],
      ),
      body: ListView.builder(itemCount: category.length,
          itemBuilder: (BuildContext context,int index){
            var items=category[index];
            TextEditingController nameController =
            TextEditingController(text: items['ABCD']);
            return Card(
              child: ListTile(
                title: Text("Category:${items["ABCD"]}"),
                trailing: SizedBox(
                  height: 50,
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SimpleDialog(
                                backgroundColor: Color(0xff092b68),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: nameController,
                                      onChanged: (value) {
                                        setState(() {
                                          name = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w100,
                                          fontSize: 18,
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width * 0.3,
                                          55),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        category[index]['ABCD'] =
                                            nameController.text;
                                      });
                                      saveData();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Update"),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        icon: Icon((Icons.edit)),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            category.removeAt(index);
                          });
                          saveData(); // Save the updated data
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),

              ),
            );

          }),
    );
  }
}
