import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List userData;
  var loading =false;

  Future getData(String item) async {
     setState(() {
       loading=true;
     });
    String url =
        "https://en.wikipedia.org/w/api.php?action=opensearch&formal=json&search=" +
            item;
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    if(response.statusCode==200){ 
    setState(() {
       userData=data;
       loading = false;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    getData("computer");
  }

  final TextEditingController srItem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Check'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // isDense: true,
                    //contentPadding: EdgeInsets.all(8),
                    labelText: 'Enter the Search Item',
                  ),
                  style: TextStyle(
                      fontSize: 16.0,
                      height: 0.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoSlabL'),
                  controller: srItem,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                iconSize: 40,
                color: Colors.black,
                splashColor: Colors.purple,
                onPressed: () async {
                  final String srVal = srItem.text;
                  await getData(srVal);
                },
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
              child: loading ? Center(child: CircularProgressIndicator(),): ListView.builder(
                
                  itemCount: userData[3] == null ? 0 : userData[3].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 10.0,),
                            if (userData[0].length > 0)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                                child: Text(
                                  "${userData[0]}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PadukB',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                            if (userData[1].length > 0)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                                child: Text(
                                  "${userData[1][index]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'openSansR',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                            if (userData[2].length > 0)
                              Padding(
                                 padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                                child: Text(
                                  "${userData[2][index]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'RobotoSlabL',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                            if (userData[3].length > 0)
                              Padding(
                                 padding: const EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                                child: Text(
                                  "${userData[3][index]}",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'openSansSBI',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0,),
                          ],
                        ),
                      ),
                    );
                  },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
