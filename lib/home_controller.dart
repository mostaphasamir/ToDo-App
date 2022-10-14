import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'model.dart';

class HomeController extends GetxController
{
   final titles=FirebaseFirestore.instance.collection('todo');
   List toDos=[];
   String? value;
   addToDo(){
      toDos.add(value);
      Get.back();
      update();
   }
   deleteToDo(index){
      toDos.removeAt(index);
      update();
   }

   addToFirestore(){
      final title=FirebaseFirestore.instance.collection('todo').doc();

      Map<String,String> dataMap ={
          'id':title.id,
         'title':value.toString(),
      };
      title.set(dataMap);
      Get.back();
      update();
   }
   deleteFromFirebase({required String id})
   {
      titles.doc(id).delete();
   }

}
