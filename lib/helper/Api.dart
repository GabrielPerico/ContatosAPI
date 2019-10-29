import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_helper.dart';
import 'pessoa_helper.dart';
import 'dart:developer' as developer;

const BASE_URL = "http://paulodir.site/rest/";

class Api {
  String token;
  Api({this.token});
  LoginHelper helper = new LoginHelper();



  Future<Login> login(String email, String senha) async {
   http.Response response = await http.post( BASE_URL + "Login", body: jsonEncode({"senha": senha,"email": email}));
    if (response.statusCode == 200) {
      print(response.body);
      Login dadosJson = new Login.fromMap(json.decode(response.body));
      return dadosJson;
    } else {
      return null;
    }
  }
  
  Future<Login> cadastro(String nome, String email, String senha) async{
    http.Response response = await http.post( BASE_URL + "Login/Cadastro",body: jsonEncode({"nome": nome, "email": email, "senha": senha}));
    if (response.statusCode == 200){
      print(response.body);
      Login dadosJson = new Login.fromMap(json.decode(response.body));
      return dadosJson;
    }else{
      return null;
    }
  }


  Future<List<Person>> contatos() async {
    http.Response response = await http.get(BASE_URL+'contato/',headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      developer.log(response.body);
      List<Person> pessoas =json.decode(response.body).map<Person>((map) {
        return Person.fromJson(map);
      }).toList();
      return pessoas;
    } else {
      return null;
    }
  }

  Future<bool> salvaContato(Person person) async{
    Logado logado = await helper.getLogado();
    http.Response response = await http.post(BASE_URL + "contato/", headers: {'token': token, 'Content-Type': 'application/json'}, body: jsonEncode({"nome": person.nome, "telefone": person.telefone, "usuario_id": logado.logado_login_id}));
    developer.log('Contato: '+ response.body);
    print('aawedaowje');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Person> atualizarContato(Person person) async {
    Logado logado = await helper.getLogado();
    http.Response response = await http.put(BASE_URL + "Contato/" + person.id,headers: {'token': token, 'Content-Type': 'application/json'},body: jsonEncode({'nome': person.nome,'telefone': person.telefone,'usuario_id': logado.logado_login_id}));
    if (response.statusCode == 200) {
      return new Person.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }


  Future<bool> deletarContato(String codigoContato) async {
    http.Response response = await http.delete(
        BASE_URL + "Contato/" + codigoContato,
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}

