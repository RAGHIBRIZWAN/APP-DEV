import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/login_signup.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Ensure this package is added in pubspec.yaml

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      });
    }
    else{
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    }
  }


  @override
  void initState() {
    super.initState();
    isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'POWERED BY',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Image.asset('assets/images/RRR LOGO real.png'),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // MaterialApp(
    //   theme: ThemeData(
    //     floatingActionButtonTheme: FloatingActionButtonThemeData(
    //       backgroundColor: Colors.black,
    //       foregroundColor: Colors.yellow
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.yellow
        ),
        title: Text('TO DO APP',style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            });
          }, icon: Icon(Icons.logout)),
          SizedBox(width: 10,),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItem()),
          );
        },
        child: Icon(Icons.add,color: Colors.yellow),
      ),
      body: PostPage(), // Added to show posts on the main page
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final auth = FirebaseAuth.instance;
  late DatabaseReference ref;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref = FirebaseDatabase.instance.ref('Posts').child(auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          TextField(
            controller: searchFilter,
            decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.search,color: Colors.black,),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: Text('Loading',style: TextStyle(color: Colors.black),),
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                final subTitle = snapshot.child('subTitle').value.toString();
                if (searchFilter.text.isEmpty || title.toLowerCase().contains(searchFilter.text.toLowerCase())) {
                  return ListTile(
                    title: Text(title,style: TextStyle(color: Colors.black,fontSize: 22),),
                    subtitle: Text(subTitle,style: TextStyle(fontSize: 18),),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 2,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              ref.child(snapshot.key!).remove();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item',style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.yellow
        ),
      ),
      backgroundColor: Colors.yellow,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: input1,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Item Name',
                    hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    prefixIcon: Icon(Icons.text_fields,color: Colors.black,),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: input2,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Item Description',
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    prefixIcon: Icon(Icons.description,color: Colors.black,),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String id = DateTime.now().microsecondsSinceEpoch.toString();
                    final userRef = FirebaseDatabase.instance.ref('Posts').child(auth.currentUser!.uid).child(id);
                    userRef.set({
                      'title': input1.text.toString(),
                      'subTitle': input2.text.toString(),
                      'id': id,
                    }).then((value) {
                      toastMessage('Post Added');
                    }).catchError((error) {
                      toastMessage(error.toString());
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
                  },style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text('Submit',style: TextStyle(color: Colors.yellow),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}


