import 'package:flutter/material.dart';
import 'package:sqfliteex/crud.dart';
import 'package:sqfliteex/datautils.dart';
import 'package:sqfliteex/detailview.dart';
import 'package:sqfliteex/sample.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Sample>> loadingSampleList() async{
    return await SqlSampleCrudRepository.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("목록 보기"),
      ),
      body: FutureBuilder(
          future: loadingSampleList(),
          builder: (context, AsyncSnapshot<List<Sample>> snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("sqflite를 사용할 수 없습니다."),);
            }else{
              if(snapshot.hasData){
                var sampleList = snapshot.data;
                return ListView.builder(
                    itemCount: sampleList!.length,
                    itemBuilder: (context, index){
                      return sampleTile(sampleList[index]);
                    });
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }
            }
          }
          ),
      floatingActionButton: FloatingActionButton(
          onPressed: createSample,
          child: const Icon(Icons.add),
      ),
    );
  }

  void createSample() async {
    int value = DataUtils.randomValue();

    var sample = Sample(
        name: DataUtils.makeUUID(),
        yn: value%2==0,
        value: value,
        createAt: DateTime.now());

    await SqlSampleCrudRepository.create(sample);
    setState(() {

    });

  }

  Widget sampleTile(Sample sample) {
    return GestureDetector(
      onTap: () async{
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailView(sample: sample)));
        setState(() {

        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 33),
              child: Text(sample.id.toString()),
            ),
            Row(
              children: [
                sample.yn
                    ? const Icon(Icons.check_box, color: Colors.green,)
                    : const Icon(Icons.check_box_outline_blank, color: Colors.green,),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  sample.name,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(sample.createAt.toString()),
            ),
          ],
        ),
      ),
    );
  }


}



















