import 'package:flutter/material.dart';
import 'package:flutter_exercise_5/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int colorCode = 0xffffffff;

  void getColorCodePref()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      colorCode = prefs.getInt('colorCode')??colorCode;
    });
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
      ),
      body: const Center(
        child: Text('ログイン成功！', style: AppTextStyles.headline,)
      ),
    );
  }
}
