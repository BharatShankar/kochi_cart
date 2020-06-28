import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practice/myModel.dart';

class TableView extends StatefulWidget {
  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List<MyModel> myarray;
  MyModel getmodelData = MyModel();
  @override
  Widget build(BuildContext context) {


  
    return Scaffold(
      appBar: AppBar(
        title: Text("Dynamic List View"),
      ),
      body:  Container(
        child: FutureBuilder(
          future: _makeGetRequest(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            return listView(context,snapshot);
          }
        )
      ),
    );
    //listView();
  }

  Widget listView(BuildContext context,AsyncSnapshot snapshot){
   if(snapshot.data == null){
     return Center(
       child:Text("Loading..")
     );
   }else{
    return ListView.separated(
      itemCount: snapshot.data.length, itemBuilder: (BuildContext context, int index) { 
        return Padding(
          
                  padding: EdgeInsets.all(20),
                  child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Title :"),
                    Flexible(child: Text(snapshot.data[index].title)),
                  ],
                ) ,
                Row(
                  children: <Widget>[
                    Text("Body :"),
                    Flexible(child: Text(snapshot.data[index].body)),
                  ],
                ) 
                
                
              ],
            ),
          ),
        );
       }, separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),

      
    );
   }
  }




  Future <List<UserData>> _makeGetRequest() async {
  // make GET request
 String url = 'https://jsonplaceholder.typicode.com/posts';
  Response response = await get(url);
  // sample info available in response
  int statusCode = response.statusCode;
  Map<String, String> headers = response.headers;
  String contentType = headers['content-type'];
  var mydata =  jsonDecode(response.body) ;

List<UserData> apidata = [];
  
for (var data in mydata){
      UserData user = UserData(data["userId"],data["id"],data["title"],data["body"]);
      apidata.add(user);
}
  
  return apidata;

  // TODO convert json to object...
}

}

class UserData {
  final int userId;
  final int id;
  final String title;
  final String body;
  UserData(this.userId,this.id,this.title,this.body);

}