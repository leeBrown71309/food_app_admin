import 'dart:convert';
import 'package:http/http.dart' as http;

class CallApiPost{
  bool isGO = false;
  postData(data, apiUrl) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    if(response.statusCode == 201){
      isGO = true;
    }
   return response;
  }
  _setHeaders()=>{
    'Content-type':'application/json',
    'Accept':'application/json',
  };
}

class CallApiGet{
  List list = [];

  Future getData(apiUrl) async {
    final http.Response response =
    await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      list = jsonDecode(response.body);
      return true;
    }else{
      return false;
    }
  }
}
