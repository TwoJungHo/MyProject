import 'package:flutter/material.dart';
import 'package:sqfliteex/crud.dart';
import 'package:sqfliteex/datautils.dart';
import 'package:sqfliteex/sample.dart';

class DetailView extends StatefulWidget {
  final Sample sample;
  const DetailView({Key? key, required this.sample}) : super(key: key);


  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  Future<Sample?> loadSample() async{
    return SqlSampleCrudRepository.getSampleId(widget.sample.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sample.id.toString()),
      ),
      body: FutureBuilder(
        future: loadSample(),
          builder: (context, AsyncSnapshot<Sample?> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("${widget.sample.id}의 정보가 없습니다."),
            );
          }else{
            if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("name : ${snapshot.data!.name}"),
                    const SizedBox(height: 10,),
                    Text("yn : ${snapshot.data!.yn}"),
                    const SizedBox(height: 10,),
                    Text("value : ${snapshot.data!.value}"),
                    const SizedBox(height: 10,),
                    Text("작성일 : ${snapshot.data!.createAt}"),
                    const SizedBox(height: 20,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {
                            update(widget.sample);
                          }, child: Text("수정"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          ),

                          SizedBox(width: 15,),
                          ElevatedButton(onPressed: () {
                            delete(widget.sample);
                          }, child: Text("삭제"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent)
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          }),
    );
  }

  void delete(Sample sample) async{
    var result = await SqlSampleCrudRepository.DeleteById(sample.id!);
    if(result > 0){
      Navigator.pop(context);
    }
  }

  void update(Sample sample) async{
    int value = DataUtils.randomValue();
    bool yn = value %2 ==0? true: false;
    var updatedSample = sample.updateSample(value: value, yn: yn);
    var result = await SqlSampleCrudRepository.updateById(updatedSample);

    if(result>0){
      setState(() {

      });
    }

  }
}
