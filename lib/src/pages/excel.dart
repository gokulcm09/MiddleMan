import 'package:agora_flutter_quickstart/src/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Excel extends StatefulWidget {
  @override
  _ExcelState createState() => _ExcelState();
}

class _ExcelState extends State<Excel> {
  var _isLoading = true;
  var _isinit = true;
  List<Map<String, dynamic>> notes;
  void launchlink() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1mgwLnPcnSaMYI8T7f-Bgsd8K6zaxVncrB-Q2ItgsMQk/edit?usp=sharing';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Couldn\'t launch');
      throw 'Could not launch $url';
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
  void didChangeDependencies() {
    if (_isinit) {
      _isinit = false;
      DBHelper.getData('notes').then((value) {
        notes = value;
        setState(() {
          _isLoading = false;
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
                  Container(
                      margin: EdgeInsets.all(20),
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: RaisedButton(
                          onPressed: launchlink,
                          child: Text('Open excel'),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )),
                ],
              ),
            ),
    );
  }
}
