import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SCR ex",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: MyHomePage(msg: "값을 넣을수 있음"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.msg}) : super(key: key);
  final String msg;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> educationList = ["초졸", "중졸", "고졸", "대졸 이상"];
  String? currentEducation;

  List<String> genderList = ["남", "여"];
  String? currentGender;

  bool isOpen = false;
  String test = "";

  List<CheckData> list = [
    CheckData("동의함", true),
    CheckData("이해함", false),
    CheckData("이해함2", false)
  ];
  List<String> checkedListName = [];

  @override

  void initstate(){
    super.initState();
    currentEducation = educationList[0];
    currentGender = genderList[0];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.msg),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  isOpen?
                  Container():
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.red,
                        value: list[0].checked,
                        onChanged: (changedValue) {
                          setState(() {
                            list[0].checked = changedValue!;
                          });
                          if(list[0].checked){
                            checkedListName.add(list[0].name);
                          }else{
                            checkedListName.remove(list[0].name);
                          }
                          print(checkedListName);
                        },

                      ),
                      Text("동의함"),
                    ],
                  ),
                 Row(
                   children: [
                     Checkbox(
                       activeColor: Colors.blue,
                       value: list[1].checked,
                       onChanged: (changedValue) {
                         setState(() {
                           list[1].checked = changedValue!;
                         });
                         if(list[1].checked){
                           checkedListName.add(list[1].name);
                         }else{
                           checkedListName.remove(list[1].name);
                         }
                         print(checkedListName);
                       },
                     ),
                     Text("이해함"),
                   ],
                 ),
                 Row(
                   children: [
                     Checkbox(
                       activeColor: Colors.blue,
                       value: list[2].checked,
                       onChanged: (changedValue) {
                         setState(() {
                           list[2].checked = changedValue!;
                         });
                         if(list[2].checked){
                           checkedListName.add(list[2].name);
                         }else{
                           checkedListName.remove(list[2].name);
                         }
                         print(checkedListName);
                       },
                     ),
                     Text("이해함2"),
                   ],),
                ],
              ),
            ],
          ),
          Switch(
            value: isOpen,
            onChanged: (changedValue) {
              setState(() {
                isOpen = changedValue;
                test = "hello world";
              });
              if (isOpen) {
                print(test);
              }
            },
            activeColor: Colors.blue,
          ),
          ElevatedButton(onPressed: () {
            checkedListName=[];
            for(int i=0; i<list.length; i++){
              checkedListName.add(list[i].name);
            }
            print(checkedListName);
          }, child: Text("서버로 전송")),

          Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Column(
              children: [
                RadioListTile(
                  title: Text(educationList[0]),
                      value: educationList[0],
                      groupValue: currentEducation,
                      onChanged: (changedValue){
                        setState(() {
                          if(changedValue != null){
                            currentEducation = changedValue;
                          }
                        });
                        print(currentEducation);
                      }
                      ),
                RadioListTile(
                    title: Text(educationList[1]),
                    value: educationList[1],
                    groupValue: currentEducation,
                    onChanged: (changedValue){
                      setState(() {
                        if(changedValue != null){
                          currentEducation = changedValue;
                        }
                      });
                      print(currentEducation);
                    }
                ),
                RadioListTile(
                    title: Text(educationList[2]),
                    value: educationList[2],
                    groupValue: currentEducation,
                    onChanged: (changedValue){
                      setState(() {
                        if(changedValue != null){
                          currentEducation = changedValue;
                        }
                      });
                      print(currentEducation);
                    }
                ),
                RadioListTile(
                    title: Text(educationList[3]),
                    value: educationList[3],
                    groupValue: currentEducation,
                    onChanged: (changedValue){
                      setState(() {
                        if(changedValue != null){
                          currentEducation = changedValue;
                        }
                      });
                      print(currentEducation);
                    }
                ),


              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Column(
              children: [
                RadioListTile(
                  title: Text(genderList[0]),
                    value: genderList[0],
                    groupValue: currentGender,
                    onChanged: (changedValue) {
                      setState(() {
                        if(changedValue != null){
                          currentGender = changedValue;
                        }
                        print(genderList[0]);
                      });
                    },),
                RadioListTile(
                  title: Text(genderList[1]),
                  value: genderList[1],
                  groupValue: currentGender,
                  onChanged: (changedValue) {
                    setState(() {
                      if(changedValue != null){
                        currentGender = changedValue;
                      }
                      print(genderList[1]);
                    });
                  },)
              ],
            ),
          )
        ],

      ),
    );
  }
}

class CheckData{
  String name = "";
  bool checked = false;

  CheckData(this.name, this.checked);
}