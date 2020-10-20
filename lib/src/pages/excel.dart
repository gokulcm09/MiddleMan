import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helpers/db_helper.dart';

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

  List<Map<String, dynamic>> notes;
  void launchlink() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('URL is empty or Invalid'),
          content: Text(
              'The provided URL is empty or invalid. Please change Excel Sheet URL'),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
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
              title: Text('Enter the Excel Sheet URL'),
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
                                  title: Text('URL is empty or Invalid'),
                                  content: Text(
                                      'The provided URL is empty or invalid.'),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx1).pop();
                                        },
                                        child: Text('Okay'))
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
                    child: Text('Change')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Cancel'))
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
      appBar: AppBar(
        title: Text('Middle Man'),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          ? Text('No notes yet!')
                          : Column(
                              children: notes
                                  .map<Widget>(
                                    (e) => Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(Icons.message),
                                          title: Text(e['info']),
                                          subtitle: Text(e['id']),
                                          trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete_forever,
                                              ),
                                              onPressed: () => del(e['id'])),
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
                            child: Text('Open Excel'),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        width: 150,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          child: RaisedButton(
                            onPressed: changeUrl,
                            child: Text('Change Excel Url'),
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
