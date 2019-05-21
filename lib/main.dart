import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(APIApp());
}

class APIApp extends StatefulWidget {
  @override
  _APIAppState createState() => _APIAppState();
}

class _APIAppState extends State<APIApp> {
  var data;
  Future<List> GetData() async {
    http.Response response = await http.get(
      Uri.encodeFull('https://jsonplaceholder.typicode.com/photos'),
      headers: {"Accept": "Application/json"},
    );
    this.setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    this.GetData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.grey[300],
      ),
      debugShowCheckedModeBanner: false,
      title: 'api',
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3.0,
          color: Colors.grey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.call),
                splashColor: Colors.cyan[100],
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                splashColor: Colors.cyan[100],
                onPressed: () {},
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan[600],
          child: Icon(Icons.add),
          onPressed: () {},
          elevation: 8,
        ),
        drawer: Drawer(
            elevation: 1.5,
            child: Column(children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.pixelstalk.net/wp-content/uploads/images2/Desktop-Images-Lamborghini-Dark-Wallpapers.jpg'),
                      fit: BoxFit.fill),
                ),
                accountEmail: Text('amirhossein13791430@gmail.com'),
                accountName: Text('#Amir'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'http://elitebasketballny.com/wp-content/uploads/2018/07/profile-placeholder.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: Text('My Cart'),
                      leading: Icon(Icons.shopping_cart),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('My Orders'),
                      leading: Icon(Icons.add_shopping_cart),
                      onTap: () {},
                    ),
                    ListTile(
                        title: Text('Logout'),
                        leading: Icon(Icons.exit_to_app),
                        onTap: () {})
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[700],
                height: 1,
              ),
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RotationTransition(
                      turns: AlwaysStoppedAnimation(0 / 360),
                      child: Icon(
                        Icons.person_outline,
                        size: 18,
                      ),
                    ),
                    Text(
                      "Amir_1430",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ])),
        appBar: AppBar(
          backgroundColor: Colors.cyan[300],
          elevation: 0,
        ),
        body: RefreshIndicator(
          color: Colors.cyan,
          onRefresh: _handleRefresh,
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              var url = data[index]['url'];
              var id = data[index]['id'];
              return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  color: Colors.grey[300],
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(url), fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'ID: $id',
                            style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            data[index]['title'],
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(milliseconds: 1500));
    return null;
  }
}
