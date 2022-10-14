import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  HomeController controller =Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('To Do App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Get.defaultDialog(
            title:'Add New ToDO' ,
            content:Container(
              margin:const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onChanged: (String value){
                  controller.value=value;
                },
              ),
            ) ,
            confirm: TextButton(onPressed: (){
              controller.addToFirestore();
            }, child:const Text('Add'
            )),
          );
        } ,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream:controller.titles.snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData)
            {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed:(direction){
                        controller.deleteFromFirebase(id: snapshot.data!.docs[index]['id']);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepOrange.withOpacity(.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text('${snapshot.data!.docs[index]['title']}',style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),),
                              Spacer(),
                              IconButton(onPressed: (){
                                controller.deleteFromFirebase(id: snapshot.data!.docs[index]['id']);
                              }, icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          else
            {
              return const Center(child: CircularProgressIndicator());
            }
        }
      ),
    );
  }
}
