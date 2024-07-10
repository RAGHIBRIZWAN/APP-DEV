import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/main.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void login(){
    _auth.signInWithEmailAndPassword(
        email: email.text.toString(), password: pass.text.toString()).then((value){
      toastMessage(value.user!.email.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));

    }).onError((error,stackTrace){
      debugPrint(error.toString());
      toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Close the app by pressing back button
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login',style: TextStyle(color: Colors.yellow),),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.yellow
          ),
        ),
        backgroundColor: Colors. yellow,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: email,
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      helperText: 'Enter your text like example@gmail.com',
                      hintStyle: TextStyle(fontSize: 20,color: Colors.black,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      helperStyle: TextStyle(color: Colors.black,fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: pass,
                    obscureText: true,
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      helperStyle: TextStyle(color: Colors.black,),
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  if(_formkey.currentState!.validate()){
                    login();
                  }
                },style:ElevatedButton.styleFrom(backgroundColor: Colors.black) , child: Text('LOGIN',style: TextStyle(color: Colors.yellow),)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Text('Do not have any Account?',style: TextStyle(fontSize: 20),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(),));
                    }, child: Text('signup',style: TextStyle(fontSize: 20),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      toastMessage("Signup successful! Please log in.");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      debugPrint(error.toString());
      toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up',style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.yellow
        ),
      ),
      backgroundColor: Colors.yellow,
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SIGN UP',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  helperText: 'Enter your email like example@gmail.com',
                  hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  helperStyle: TextStyle(color: Colors.black,fontSize: 15),
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  helperStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    signup();
                  }
                },style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: loading
                    ? CircularProgressIndicator()
                    : Text('SIGN UP',style: TextStyle(color: Colors.yellow),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account?',style: TextStyle(fontSize: 20),),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Login',style: TextStyle(fontSize: 20),))
              ],
            )
          ],
        ),
      ),
    );
  }
}


//FLUTTER TOAST
void toastMessage(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
