import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:traptrafikkers/screens/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SpeechToText extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().contacts,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: VoiceHome(),
      ),
    );
  }
}

class VoiceHome extends StatefulWidget {

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }
  String contact1FromFirebase="",contact2FromFirebase="",contact3FromFirebase="";

  callIfReq(){
    FlutterPhoneDirectCaller.callNumber(contact1FromFirebase);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Speech To Text'),
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.cancel),
                    mini: true,
                    backgroundColor: Colors.deepOrange,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.cancel().then(
                              (result) => setState(() {
                            _isListening = result;
                            resultText = "";
                          }),
                        );
                    },
                  ),
                  FloatingActionButton(
                    heroTag: 'btn1',
                    child: Icon(Icons.mic),
                    onPressed: () async {
                      if (_isAvailable && !_isListening)
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => print('$result'));
                      //printing doc data from firestore
                      var i=0;
                      final contacts = Provider.of<QuerySnapshot>(context);
                      for(var doc in contacts.documents) {
                        if(i==0){
                          contact1FromFirebase=doc.data['contact1'];
                        }
                        else if(i==1){
                          contact2FromFirebase=doc.data['contact2'];
                        }
                        else if(i==2){
                          contact3FromFirebase=doc.data['contact3'];
                        }
                        i++;
                      }
                      print('contact1FromFirebase, contact1FromFirebase, contact1FromFirebase is :');
                      print(contact1FromFirebase);
                      print(contact2FromFirebase);
                      print(contact3FromFirebase);
                      callIfReq();
                    },
                    backgroundColor: Colors.pink,
                  ),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    child: Icon(Icons.stop),
                    mini: true,
                    backgroundColor: Colors.deepPurple,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.stop().then(
                              (result) => setState(() => _isListening = result),
                        );
                    },
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  resultText,
                  style: TextStyle(fontSize: 24.0),
                ),
              )
            ],
          ),
        ),

      );
  }
}