import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextWidget(title: 'Flutter Issues'),
    );
  }
}

class TextWidget extends StatefulWidget {
  TextWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  final myController = TextEditingController();

  List<Map<String, dynamic>> items = [];

  //　追加ボタンが押されたときに実行する関数
  void _addItem(String inputtext) {
    setState(() {
      items.add({"content": inputtext});
    });
  }

  @override
  // widgetの破棄時にコントローラも破棄する
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Center(
        child: Column(
            children: <Widget>[
              TextField(
                controller: myController,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write something',
                ),
                maxLines: null,
              ),

              //テキストフィールド送信用ボタン
              RaisedButton(
                child: Text('Save!'),
                onPressed: (){
                  //テキストフィールドを送信するための関数呼び出し
                  _addItem(myController.text);
                  //テキストフィールドを空にする
                  myController.clear();
                },
              ),

              //送信されたテキストをListで表示
              Expanded(
                child:ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = items[index];

                      return new Card(
                        child: Text(item["content"]),
                      );
                    }
                )
              ),
            ]
        )
      )
    );
  }
}
