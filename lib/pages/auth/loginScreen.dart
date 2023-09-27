// ignore_for_file: dead_code, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epikrizimweb/pages/main/randevuScreen.dart';
import 'package:epikrizimweb/servisler/showLoading.dart';
import 'package:epikrizimweb/servisler/showToast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String _ipAdres = '217.131.39.237';
  String _port = '5946';

  int _firmaNo = 0;

  var _jsonData = [];

  TextEditingController _emailEdit = TextEditingController();
  TextEditingController _passEdit = TextEditingController();

  @override
  void dispose() {
    _emailEdit.clear();
    _passEdit.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundflu.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'şimdi giriş yap',
                  style: GoogleFonts.indieFlower(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Text(
                  'Epikrizimin size sunduğu ayrıcalıklı dünyaya giriş yapın',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w300,
                        // height: 1.5,
                        fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 500
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width / 1.05,
                  height: isEmailCorrect! ? 250 : 200,
                  child: Container(
                    height: isEmailCorrect! ? 250 : 200,
                    // _formKey!.currentState!.validate() ? 200 : 600,
                    // height: isEmailCorrect ? 260 : 182,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEdit,
                            onChanged: (val) {
                              setState(() {
                                isEmailCorrect = isEmail(val);
                              });
                            },
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "e-mail",
                              hintText: 'isim.soyisim@domain.com',
                              labelStyle: TextStyle(color: Colors.purple),
                              // suffixIcon: IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.close,
                              //         color: Colors.purple))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _passEdit,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "parola",
                                hintText: '*********',
                                labelStyle: TextStyle(color: Colors.purple),
                              ),
                              validator: (value) {
                                if (value!.isEmpty && value!.length < 5) {
                                  return 'geçerli bir şifre giriniz';
                                  {
                                    return null;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isEmailCorrect
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    backgroundColor: isEmailCorrect == false
                                        ? Colors.red
                                        : Colors.purple,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                5.3,
                                        vertical: 20)
                                    // padding: EdgeInsets.only(
                                    //     left: 120, right: 120, top: 20, bottom: 20),
                                    ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ShowLoadinPage(context);
                                    if (await GetLogin(_emailEdit.text.trim(),
                                        _passEdit.text)) {
                                      Navigator.of(context).pop();
                                      toastGetir('giriş başarılı', 0);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RandevuScreen(_firmaNo),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                      toastGetir(
                                          'kullanıcı adı veya şifre doğrulaması yapılamadı. lütfen tekrar deneyin',
                                          1);
                                    }
                                  }
                                },
                                child: Text(
                                  'giriş yap',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'hesabınız yok mu ?',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'hesap oluştur',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'parolamı unuttum',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> GetLogin(String email, String pass) async {
    Map data = {"email": email, "pass": pass};
    var jsonBody = json.encode(data);

    try {
      final dio = Dio();
      var url = 'http://$_ipAdres:$_port/api/LoginEpikrizim';
      final response = await dio
          .post(url,
              options: Options(contentType: 'application/json'), data: jsonBody)
          .timeout(Duration(seconds: 6));
      _jsonData = response.data;
      //_hastaneAdi = _jsonHastane[0]['hastane'];
      print('Giriş verileri getirildi..${response.data}');
      _jsonData[0]['firmano'] != null
          ? _firmaNo = int.parse(_jsonData[0]['firmano'].toString())
          : _firmaNo = 0;

      if (_firmaNo < 9999)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      setState(() {});
      return false;
    }
  }

  String TarihFormat(String tar) {
    DateTime parsedDate = DateTime.parse(tar);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    //print(formattedDate);

    return formattedDate;
  }

  String SaatFormat(String saat) {
    DateTime parsedDate = DateTime.parse(saat);
    String formattedDate = DateFormat.Hm().format(parsedDate);
    //print(formattedDate);

    return formattedDate;
  }
}
