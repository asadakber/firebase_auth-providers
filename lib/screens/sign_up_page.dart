import 'package:flutter/material.dart';
import 'package:flutter_auth_providers/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  TextEditingController _email;
  TextEditingController _password;
  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
  }
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('RegisterPage'),

      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _email,
                  validator: (value) => (value.isEmpty) ? "Please Enter Email": null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _password,
                  validator: (value) => (value.isEmpty) ? "Please Enter Password": null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      border: OutlineInputBorder()
                  ),
                  obscureText: true,
                ),
              ),
              user.status == Status.Authenticating
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red,
                  child: MaterialButton(
                    onPressed: () async {
                      if(_formkey.currentState.validate()) {
                        if(!await user.signUp(
                          _email.text, _password.text))
                          _key.currentState.showSnackBar(SnackBar(
                            content: Text("Something is wrong"),
                          ));
                      }
                    },
                    child: Text(
                      "Sign_up"
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();

  }
}

