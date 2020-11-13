import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/DBHelper.dart';

class Excel extends StatefulWidget {
  @override
  _ExcelState createState() => _ExcelState();
}

class _ExcelState extends State<Excel> {
  var _isLoading = true;
  var _isinit = true;
  final storage = FlutterSecureStorage();
  final _urlController = TextEditingController();
  var url;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> notes;
  void launchlink() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'URL is empty or Invalid',
            style: GoogleFonts.openSans(),
          ),
          content: Text(
            'The provided URL is empty or invalid. Please change Excel Sheet URL',
            style: GoogleFonts.openSans(),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: GoogleFonts.openSans(),
                ))
          ],
        ),
      );
    }
  }

  void del(String id) {
    DBHelper.delete('notes', id);
    setState(() {
      _isinit = true;
      _isLoading = true;
    });
    didChangeDependencies();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void changeUrl() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Enter the Excel Sheet URL',
                style: GoogleFonts.openSans(),
              ),
              content: TextField(
                keyboardType: TextInputType.url,
                controller: _urlController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, right: 10, top: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'Enter Excel Sheet URL',
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      if (_urlController.text == "" ||
                          _urlController.text.isEmpty ||
                          _urlController.text == null) {
                        showDialog(
                            context: ctx,
                            builder: (ctx1) => AlertDialog(
                                  title: Text(
                                    'URL is empty or Invalid',
                                    style: GoogleFonts.openSans(),
                                  ),
                                  content: Text(
                                    'The provided URL is empty or invalid.',
                                    style: GoogleFonts.openSans(),
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx1).pop();
                                        },
                                        child: Text(
                                          'Okay',
                                          style: GoogleFonts.openSans(),
                                        ))
                                  ],
                                ));
                      } else {
                        setState(() {
                          _isLoading = true;
                        });
                        url = _urlController.text;
                        storage
                            .write(key: 'excel', value: _urlController.text)
                            .then((value) {});
                        setState(() {
                          _isLoading = false;
                          Navigator.of(ctx).pop();
                        });
                      }
                    },
                    child: Text(
                      'Change',
                      style: GoogleFonts.openSans(),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.openSans(),
                    ))
              ],
            ));
  }

  Future<void> getExcelUrl() async {
    String value = await storage.read(key: 'excel');
    if (value != null || value != "") {
      url = value;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
        _isinit = false;
      });
      getExcelUrl().then((value) {
        DBHelper.getData('notes').then((value) {
          notes = value;
          setState(() {
            _isLoading = false;
          });
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Middle Man',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: 300,
                    child: Text(
                      'Notes',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: 300,
                    child: SingleChildScrollView(
                      child: notes.isEmpty
                          ? Text(
                              'No notes yet!',
                              style: GoogleFonts.openSans(),
                            )
                          : Column(
                              children: notes
                                  .map<Widget>(
                                    (e) => Column(
                                      children: <Widget>[
                                        ListTile(
                                          onLongPress: () {
                                            Clipboard.setData(
                                                ClipboardData(text: e['info']));
                                            final snackBar = SnackBar(
                                              content:
                                                  Text('Copied to Clipboard'),
                                            );
                                            scaffoldKey.currentState
                                                .showSnackBar(snackBar);
                                          },
                                          leading: Icon(Icons.message),
                                          title: Text(
                                            e['info'],
                                            style: GoogleFonts.openSans(),
                                          ),
                                          subtitle: Text(
                                            e['id'],
                                            style: GoogleFonts.openSans(),
                                          ),
                                          trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              "Are you sure?",
                                                              style: GoogleFonts
                                                                  .openSans()),
                                                          content: Text(
                                                              'Are you sure you want to delete this note permanently?',
                                                              style: GoogleFonts
                                                                  .openSans()),
                                                          actions: [
                                                            FlatButton(
                                                              onPressed: () {
                                                                del(e['id']);
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text('Yes',
                                                                  style: GoogleFonts
                                                                      .openSans()),
                                                            ),
                                                            FlatButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'No',
                                                                    style: GoogleFonts
                                                                        .openSans()))
                                                          ],
                                                        ));
                                              }),
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          child: RaisedButton(
                            onPressed: url == null ? null : launchlink,
                            child: Text(
                              'Open Excel',
                              style: GoogleFonts.openSans(),
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 175,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          child: RaisedButton(
                            onPressed: changeUrl,
                            child: Text(
                              'Change Excel Url',
                              style: GoogleFonts.openSans(),
                            ),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
