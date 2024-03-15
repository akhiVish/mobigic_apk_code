import 'package:flutter/material.dart';
import 'package:mobigic_test/constant/constant.dart';
import 'package:mobigic_test/screens/gridView_screen.dart';

class DashboardSccreen extends StatefulWidget {
  const DashboardSccreen({super.key});

  @override
  State<DashboardSccreen> createState() => _DashboardSccreenState();
}

class _DashboardSccreenState extends State<DashboardSccreen> {
  final formKey = GlobalKey<FormState>();
  final rowsController = TextEditingController();
  final columnController = TextEditingController();
  final alphabetController = TextEditingController();

  int alphabetMaxlength = 1;

  List<String> alphabetsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // rowsController.addListener(multiplyControllerValue);
    // columnController.addListener(multiplyControllerValue);
  }

  void multiplyControllerValue(String row, String column) {
    int rowValue = int.tryParse(row) ?? 1;
    int columnValue = int.tryParse(column) ?? 1;

    int value = rowValue * columnValue;
    setState(() {
      value != 0 ? alphabetMaxlength = value : alphabetMaxlength = 1;

      print('alphabetMaxlength--------->$value');
    });
  }

  void addDataInToList() {
    // String value=text
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBarBackgroundColor,
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: rowsController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 3,
                  onChanged: (value) {
                    if (value != '0') {
                      multiplyControllerValue(value, columnController.text);
                    }
                  },

                  // maxLength: 50,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      counterText: '',
                      labelText: 'Enter Row Count',
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: columnController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLength: 3,
                  onChanged: (value) {
                    if (value != '0') {
                      multiplyControllerValue(rowsController.text, value);
                    }
                  },
                  decoration: const InputDecoration(
                      labelText: 'Enter Column Count',
                      counterText: '',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: alphabetController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.characters,
                  // keyboardAppearance:,
                  maxLength: alphabetMaxlength,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      counterText: '',
                      labelText: 'Enter Alphabet',
                      border: InputBorder.none),
                  onChanged: (value) {
                    setState(() {
                      alphabetsList.clear();
                      for (int i = 0; i < value.length; i++) {
                        alphabetsList.add(value[i]);
                      }

                      print('alphabetsList----->$alphabetsList');
                    });
                  },
                  // validator: (value) => value == null ? '' : null
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 6,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * .6, 50)),
                  // style: ButtonStyle(
                  //     // elevation: ,
                  //     minimumSize: MaterialStateProperty.all(
                  //         Size())),
                  onPressed: () {
                    // Check if there's data in rowCount, columnCount, or alphabet
                    if ((rowsController.text.isNotEmpty &&
                            rowsController.text != '0') ||
                        (columnController.text.isNotEmpty &&
                            columnController.text != '0')) {
                      // Check if there's data in alphabet if one of the other fields has data
                      if (alphabetController.text.isNotEmpty) {
                        // Navigate to GridViewScreen

                        if (alphabetMaxlength == alphabetsList.length) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GridViewScreen(
                                alphaList: alphabetsList,
                                rowCount: rowsController.text,
                                columnCount: columnController.text,
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(
                                  'There should be $alphabetMaxlength character'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        // Show error message if alphabet is empty
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Please enter data in the alphabet field.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      // Show error message if none of the fields have valid data
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Please enter valid data in at least one field.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Display Gridview',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ))
            ],
          ),
        ));
  }
}
