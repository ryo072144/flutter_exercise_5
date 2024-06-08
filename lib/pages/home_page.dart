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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  int _colorCode = Colors.blue.value;

  void setAccountPrefs() async {
    SharedPreferences prefs = await _prefs;
  }

  void setColorCodePref(int newColorCode) async {
    SharedPreferences prefs = await _prefs;
  }

  void getColorCodePref() async {
    SharedPreferences prefs = await _prefs;
  }

  Future<String?> getPasswordByID() async {
    SharedPreferences prefs = await _prefs;
    String? password = prefs.getString(_idEditingController.text);
    return password;
  }

  // ウィジェットが生成されるときに実行されるメソッド
  @override
  void initState() {
    super.initState();
    getColorCodePref();
  }

  // ウィジェットが破棄されるときに実行されるメソッド
  @override
  void dispose() {
    // コントローラーのインスタンスを破棄して、メモリを節約します
    _idEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイトル', style: AppTextStyles.title),
        backgroundColor: Color(_colorCode),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value){},
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
          width: MediaQuery.of(context).size.width / 2,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _idEditingController,
                  validator: (val) => val!.length < 4 ? 'IDは4文字以上必要です' : null,
                  decoration: const InputDecoration(
                      labelText: 'ID', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordEditingController,
                  validator: (val) =>
                      val!.length < 6 ? 'パスワードは6文字以上必要です' : null,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'パスワード',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    setAccountPrefs();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(_colorCode),
                  ),
                  child: const Text('アカウント作成', style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? password = await getPasswordByID();

                    // 非同期関数の中でcontextを使うときはこの一文が必要です。
                    if(!mounted)return;

                    if (password == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('登録されていないIDです'),
                      ));
                    } else if (password != _passwordEditingController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('パスワードが違います'),
                      ));
                    }else {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultPage()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color(_colorCode),
                  ),
                  child: const Text('ログイン', style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
