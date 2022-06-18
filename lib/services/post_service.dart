import 'dart:convert';

import 'package:http/http.dart' as http;
class PostService{
  String baseUrl="https://sids438.pythonanywhere.com/login/";
   Future<String> createPost(Map<String,dynamic>data)async{
   try{
     var response=await http.post(Uri.parse("$baseUrl/create"),body: jsonEncode(data),
         headers: {
       "Content-Type": "application/json; charset=UTF-8",
         });
     if(response.statusCode==200)
       {
         return "Success";
       }else{
       return "error";
     }
   }catch(SocketException){
     return "error";
   }
  }
}