import 'package:flutter/material.dart';
import 'package:mobigic_test/constant/constant.dart';

class GridViewScreen extends StatefulWidget {
  final List<String> alphaList;
  final String rowCount;
  final String columnCount;

  const GridViewScreen(
      {super.key,
      required this.alphaList,
      required this.rowCount,
      required this.columnCount});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'GridView Screen',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: widget.alphaList.length != 0
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: 'Search',
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (widget.columnCount) != null
                            ? int.tryParse(widget.columnCount) ?? 2
                            : 2),
                    itemCount: widget.alphaList.length,
                    itemBuilder: (context, index) {
                      final item = widget.alphaList[index];
                      final bool isHighlighted =
                          item.toLowerCase() == searchText.toLowerCase();

                      return Card(
                        color: isHighlighted ? Colors.orange : Colors.blue,
                        child: Center(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  isHighlighted ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(child: Text('No Data')),
    );
  }
}
