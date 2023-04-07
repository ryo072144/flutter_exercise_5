import 'package:flutter/material.dart';
import 'package:flutter_exercise_5/constants/text_styles.dart';
import 'package:flutter_exercise_5/pages/result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController idEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  int colorCode = Colors.blue.value;

  void setPrefs()async{
    SharedPreferences prefs = await _prefs;
    prefs.setString(idEditingController.text, passwordEditingController.text);
  }

  void setColorCodePref(int newColorCode)async{
    SharedPreferences prefs = await _prefs;
    prefs.setInt('colorCode', newColorCode);
    setState(() {
      colorCode = newColorCode;
    });
  }

  void getColorCodePref()async{
    SharedPreferences prefs = await _prefs;
    colorCode = prefs.getInt('colorCode')??colorCode;
  }

  @override
  void initState() {
    super.initState();
    getColorCodePref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイトル', style: AppTextStyles.title),
        backgroundColor: Color(colorCode),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) => setColorCodePref(value),
            icon: const Icon(Icons.format_paint),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: Colors.blue.value,
                  child: const Text('ブルー'),
                ),
                PopupMenuItem(
                  value: Colors.green.value,
                  child: const Text('グリーン'),
                ),
                PopupMenuItem(
                  value: Colors.yellow.value,
                  child: const Text('イエロー'),
                )
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: idEditingController,
                decoration: const InputDecoration(labelText: 'ID', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: passwordEditingController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'パスワード', border: OutlineInputBorder(),),
              ),
              const SizedBox(height: 40,),
              ElevatedButton(
                onPressed: (){

                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(colorCode),
                ),
                child: const Text('アカウント作成', style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultPage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(colorCode),
                ),
                child: const Text('ログイン', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

