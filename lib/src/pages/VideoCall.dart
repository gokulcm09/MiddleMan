import 'dart:async';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:intl/intl.dart';
import 'package:screen/screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/DBHelper.dart';
import '../utils/Settings.dart';

class VideoCall extends StatefulWidget {
  final String channelName;
  final ClientRole role;
  VideoCall({this.channelName, this.role});
  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  bool _joined = false;
  int _remoteUid;
  bool _switch = false;
  bool validateError = false;
  bool isVideoOff = false;
  bool muted = false;
  StreamSubscription _volumeButtonSubscription;
  TextEditingController _text = TextEditingController();
  RtcEngine engine;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    Screen.keepOn(true);
  }

  void save(TextEditingController txt) {
    if (txt.text.isEmpty) {
      setState(() {
        txt.text = "";
        validateError = true;
      });
      return;
    } else {
      DateTime msg = DateTime.now();
      String label = DateFormat().format(msg);
      DBHelper.insert('notes', {
        'id': label,
        'info': txt.text,
      });
      setState(() {
        txt.text = "";
        validateError = false;
      });
    }
  }

  Future<void> initPlatformState() async {
    engine = await RtcEngine.create(APP_ID);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      setState(() {
        _remoteUid = null;
      });
    }));
    await engine.enableVideo();
    await engine.enableAudio();
    await engine.joinChannel(null, widget.channelName, null, 0);
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    engine.switchCamera();
  }

  void _onToggleVideo() {
    setState(() {
      isVideoOff = !isVideoOff;
    });
    engine.muteLocalVideoStream(isVideoOff);
  }

  @override
  void dispose() {
    _volumeButtonSubscription?.cancel();
    _text.dispose();
    engine.leaveChannel();
    engine.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Middle Man',
          style: GoogleFonts.openSans(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                        _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
            _toolbar(),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        errorText: validateError ? 'Notes is mandatory' : null,
                        labelText: 'Notes',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 48,
                    child: RaisedButton(
                        child: Text(
                          'Save',
                          style: GoogleFonts.openSans(color: Colors.white),
                        ),
                        onPressed: () => save(_text),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderLocalPreview() {
    if (_joined && !isVideoOff) {
      return RtcLocalView.SurfaceView();
    } else if (_joined && isVideoOff) {
      return Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text('Your Video is OFF',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),
      );
    } else {
      return Text(
        'Please join channel first',
        style: GoogleFonts.openSans(),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait for robot to join',
        style: GoogleFonts.openSans(),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),
            RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: muted ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
            RawMaterialButton(
              onPressed: _onSwitchCamera,
              child: Icon(
                Icons.switch_camera,
                color: Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
            RawMaterialButton(
              onPressed: _onToggleVideo,
              child: Icon(
                isVideoOff ? Icons.videocam_off : Icons.videocam,
                color: isVideoOff ? Colors.white : Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: isVideoOff ? Colors.blueAccent : Colors.white,
              padding: const EdgeInsets.all(12.0),
            )
          ],
        ),
      ),
    );
  }
}
