import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practice/tblView.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

var textController = TextEditingController();
var passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _scaffKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Colors.grey[200],
      body: bodyWidget(context),
    );
  }


  _makeGetRequest() async {
  // make GET request
  String url = 'https://jsonplaceholder.typicode.com/posts';
  Response response = await get(url);
  // sample info available in response
  int statusCode = response.statusCode;
  Map<String, String> headers = response.headers;
  String contentType = headers['content-type'];
  String json = response.body;
  //print(json);
  Navigator.push(context, MaterialPageRoute(builder: (context) => TableView()));
  
  // TODO convert json to object...
}

  Widget bodyWidget(BuildContext context){
    return SingleChildScrollView(
          key: _scaffKey,
          child: Container(
          child: Column(
            children: <Widget>[
              topView(context),
              bottomView(context),
            ],
          ),
        ),
    );
  }

  Widget topView(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      color: Colors.purple[800],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text("SIGN IN\nTO CONTINUE",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
          ),

        ],
      ),
    );
  }

  Widget bottomView(BuildContext context){
    return Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(5.0)),
           color: Colors.white
           ),
            //color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left:20,right:20,bottom:20),
              child: Column(
                children: <Widget>[
                  nameTxtField(context),
                  SizedBox(
              height: MediaQuery.of(context).size.height*0.04,
            ),
                  passwordTxtField(context),
                  SizedBox(
              height: MediaQuery.of(context).size.height*0.06,
            ),
                  Container(child: signinButton(context),width: MediaQuery.of(context).size.width * 0.8,height: 40,)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  String validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contains more then 5 character";
  }
  return null;
}

  Widget nameTxtField(BuildContext context){
    return TextField(
                  controller: textController,
                  decoration: InputDecoration(hintText: 'Email ID',errorText: validatePassword(textController.text) ),
                  
                );
  }

  Widget passwordTxtField(BuildContext context){
    return TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: 'Password', ),
                  validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
                );
  }

  Widget signinButton(BuildContext context){
    return RaisedButton(onPressed: (){
      if(validatePassword(textController.text) == null && passwordController.text != "" ){
        _makeGetRequest();
      }else{
       print("enter some info");
      }
      
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize:20),),
    color: Colors.purple[800],
    );
  }

}