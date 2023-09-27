// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RandevuScreen extends StatefulWidget {
  final int _firmaNo;
  const RandevuScreen(this._firmaNo, {super.key});

  @override
  State<RandevuScreen> createState() => _RandevuScreenState();
}

class _RandevuScreenState extends State<RandevuScreen> {
  TextEditingController _tcNoSearc = TextEditingController();

  int _seciliIndex = 0;
  DateTime? _seciliTar;

  String? _randTarih;

  List<String> list = <String>['Erkek', 'Kadın'];
  String _cinsiyet = 'Erkek';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _seciliTar == null ? DateTime.now() : _seciliTar!,
      firstDate: DateTime.now().add(Duration(days: -2000)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) => value == null ? DateTime.now() : value));
    if (picked != null && picked != _seciliTar) {
      setState(() {
        _seciliTar = picked;
        _randTarih = TarihFormat(_seciliTar.toString());
      });
    }
    print(_randTarih);
  }

  InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedFontSize: 11,
            unselectedItemColor: Colors.white.withOpacity(0.50),
            currentIndex: _seciliIndex,
            onTap: (value) {
              _seciliIndex = value;
              _seciliIndex == 3 ? _selectDate(context) : null;
              setState(() {});
            },
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidCalendarCheck,
                ),
                label: 'Kayıt Aç',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: 'Yeni Randevu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: 'Randevu Düzenle',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Tarih Seç',
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Row(
          children: [
            SizedBox(
              width: 500,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.file),
                          tooltip: 'Yeni',
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Hasta Ara'),
                              content: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 11,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: 'T.C. Kimlik No',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Vazgeç'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ara'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(Icons.search),
                          tooltip: 'Ara',
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Kaydet'),
                              content: const Text(
                                  'Hasta bilgileri kayıt edilsin mi ?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Vazgeç'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Kaydet'),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(Icons.save),
                          tooltip: 'Kaydet',
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.list),
                          tooltip: 'Hasta Listesi',
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 3),
                  Column(
                    children: [
                      SizedBox(
                        child: Text('Hasta Kimlik Bilgileri'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: 'T.C. Kimlik No',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              inputFormatters: [maskFormatter],
                              decoration: InputDecoration(
                                labelText: 'Doğum Tarihi',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Adı',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Soyadı',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: DropdownButtonFormField(
                              value: _cinsiyet,
                              decoration: inputDecoration,
                              //icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),

                              //underline:
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  _cinsiyet = value!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                labelText: 'Telefon',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          SizedBox(
                            width: 410,
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'E-Mail',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 3),
                  Text('Önceki Geliş Bilgileri'),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 600,
                    height: 200,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text('17/06/2023'),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text('Hasta Bilgileri'),
                                      Text(
                                        'Hasta Detay Bilgileri',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  MediaQuery.of(context).size.width < 990
                      ? Column(
                          children: [
                            Divider(thickness: 3),
                            SizedBox(height: 10),
                            Text('Randevular'),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 450,
                              height: 540,
                              child: ListView.builder(
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text('${index + 1}'),
                                          SizedBox(width: 5),
                                          Icon(FontAwesomeIcons.clock),
                                          SizedBox(width: 10),
                                          Text('09:00'),
                                          SizedBox(width: 30),
                                          Column(
                                            children: [
                                              Text(
                                                'Hasta Adı Soyadı',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Hasta Detay Bilgileri',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(width: 30),
            MediaQuery.of(context).size.width > 990
                ? Column(
                    children: [
                      SizedBox(height: 25),
                      Text(
                          '${MediaQuery.of(context).size.width} x ${MediaQuery.of(context).size.height}'),
                      Text('Randevular'),
                      SizedBox(
                        width: 450,
                        height: 540,
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('${index + 1}'),
                                    SizedBox(width: 5),
                                    Icon(FontAwesomeIcons.clock),
                                    SizedBox(width: 10),
                                    Text('09:00'),
                                    SizedBox(width: 30),
                                    Column(
                                      children: [
                                        Text(
                                          'Hasta Adı Soyadı',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Hasta Detay Bilgileri',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatterSaat = MaskTextInputFormatter(
      mask: '##:##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  String TarihFormat(String tar) {
    DateTime parsedDate = DateTime.parse(tar);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }
}
