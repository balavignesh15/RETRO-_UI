import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';



class newexp extends StatefulWidget {
  late ExpenseData expenseData;
  List<Map<String, String>> selectedCategoryList = [];

  newexp({Key? key, required this.selectedCategoryList}) : super(key: key);

  @override
  State<newexp> createState() => _newexpState();
}



class _newexpState extends State<newexp> {
  late ExpenseData expenseData;
  String? selectedCategory;

  void addItemList(){
    String text = dateController.text;
    String text1 = amountController.text;
    if (text.isNotEmpty &&text1.isNotEmpty){
      setState(() {
        var items={
          "date":text,
          "amount":text1,
        };
        Navigator.pop(context,items);
      });
    }

  }


  @override
  void initState() {
    super.initState();
    expenseData = ExpenseData();

    // Initialize selectedCategory with the first item in categoryList
    selectedCategory = widget.selectedCategoryList.isNotEmpty ? widget.selectedCategoryList[0]["ABCD"] : null;
  }




  ///date
  /// DateTime? selectedDate;

  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = '${selectedDate!.toLocal()}'.split(' ')[0];
      });
    }
  }

  ///dropdown


  String? selectedOption = 'Option 1';
  List<String> optionItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];





  ///uploadimage
  Uint8List? _image;
  File? selectedIMage;



  ///route
  TextEditingController cnt= TextEditingController();
  List input=[];
  void _addItemToList()
  {
    String text= cnt.text;
    setState(() {
      input.add("$text");
      cnt.clear();
    });

  }
  String text1="";

  void delete(index){
    setState(() {
      input.removeAt(index);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range_rounded,),
                labelText: 'Date',
                labelStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                    fontFamily: "Outfit"),),

            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child:  DropdownButton(
                icon: Icon(Icons.arrow_drop_down, size: 36),
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 20),
                underline: SizedBox(),
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items:widget. selectedCategoryList.map<DropdownMenuItem<String>>((Map<String, String> value) {
                  return DropdownMenuItem<String>(
                    value: value["ABCD"],
                    child: Text(value["ABCD"]!),
                  );
                }).toList(),
              ),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range_rounded,),
                labelText: 'Spent Amount',
                labelStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                    fontFamily: "Outfit"),),

            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: DropdownButton(
                icon: Icon(Icons.arrow_drop_down, size: 36),
                isExpanded: true,
                style: TextStyle(color: Colors.black, fontSize: 20),
                underline: SizedBox(),
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
                items: optionItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [SizedBox(width: 100,),
                Text('Attachment',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                    fontFamily: "Outfit"),),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: (){
                    showImagePickerOption(context);
                  },
                  child: Text('Upload'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(),
                  ),)

              ],
            ),
            ElevatedButton(
              onPressed: (){
                expenseData.date = selectedDate;
                expenseData.category = selectedCategory;
                expenseData.amount = amountController.text;
                expenseData.option = selectedOption;
                expenseData.image = _image;
                addItemList();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(expenseData: expenseData)));

              }, child: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(),
              ),),
          ],
        ),
      ),
    );


  }


  ///image upload fuc
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {

                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      // selectedIMage = File(returnImage.path);
      // _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      // selectedIMage = File(returnImage.path);
      // _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }
}





///view page
class ViewPage extends StatelessWidget {
  final ExpenseData expenseData;

  const ViewPage({Key? key, required this.expenseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Expense"),

      ),
      body: Column(
          children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: ${DateFormat('yyyy-MM-dd').format(expenseData.date!)}"),
                Text("Category: ${expenseData.category}"),
                Text("Amount: ${expenseData.amount}"),
                Text("Option: ${expenseData.option} "),
                // Display image if available
                if (expenseData.image != null) Image.memory(expenseData.image!),
              ],
            ),
          ]
      ),
    );
  }
}


class ExpenseData {
  DateTime? date;
  String? category;
  String? amount;
  String? option;
  Uint8List? image;

  ExpenseData({this.date, this.category, this.amount,this.option, this.image});

}


