// import 'dart:html';
// import 'homePage.dart';
import 'package:gsheets/gsheets.dart';

class GoogleAPI{
  static String spreadSheetId='1VBcMpHY7FrWkqDsUJItYzdwabGtBlUWwo54_j1h33nw';

  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "flutterproject-391902",
  "private_key_id": "4628f94b0e6b2fc5a7267f35bdb6080c67864d71",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDYOUgANBGLFb7y\nGBrTMOmstUIL6Eodr2jZJecvedDO84NoHaWLWJGJMB+mg+zvwKM+pOwJHgciAM7n\nLi3lg7ZUB4IowjFWY2n/Ort+jjLOaEBkzv/c0LrF82DvQOXt2LUuO47NAiLaxrQf\nGYjyCqQUGG1S3mhnO0zH1PQO9WhM1DNaLnygG5NEx2XST+/kPN6TcuZfeSRU3Z0m\nIJrpJe6p2po7tHRCEL3bcXrwYqM5LF+pTUk5rnYi5QS99AxSBX9UWbU3/fiYnQEr\nj0pQdO35w2izqz6EflJewTahDTr8/4tj5Y18I2295pWcOWYGi/oSf8lHtSU7NArD\ngzK2p0RNAgMBAAECggEABuhHJVqEeCdifJfKI5aboGmZ8CKkW3zP1XM67QiJlx+u\nwi2Dee22ZUxYQ0vrm2BRo4RGCUFThDT3M+nRvyDaB9n4wOL5pVAMggH9g1ysWtOr\nWvN4UQGKArdBQ+NhQc8U2qLXopm/q0vo7SVpSCVdRuPdrWWiSDBb+Sl5/0OJTwry\n7aI2NHi6RbKawBzXffyXNM8Xk3QbUyPU9SnpDjExWygQXI8HeH/rmmN2o5b8owqm\nkZ25LnsnZAYarxFr/CzM93Re6IYjbw3ImhL1iSaegn90TH55qqi3rX2sPDCsCFQr\nwWlRySjEU0xXeehu3jCpnOreHfJplqtrh0xqvHj5AQKBgQDrh8VKoGWmRjoYnjQ8\nASi6ARNHQTHvigAJKu0j4gBqwxfhDMRq+kjf0inqDkhPal4Hf+3NBdCvYe8+1oWQ\n1b73pKc+SjEShyAkqTLmhwM/V9GOrq3L6nXb9HJaFX0201GhIIdcPdUwlg2Svdl6\no/OgjN+B2q6lGLijpNjsOqrU3QKBgQDrA/cOjXzBdeKlNFqNfQpQB3qSxmABuUNN\nCVP2xVS4fKVWgLGGQbFCBXsXHOQCLAUGi6X3Vd4JX4rQ6ZIbhcQXdA7QIYSdC5FA\nG/65Xh1NpvypT3wO+mO89+ML29x8XIWaJi7x2FtDaIY1Q+zJN854JIcotUBFs1Sw\npJcMkBM+MQKBgE9kTamRFZKNu4mO0lajoWHJeQEcxcNTxh1Q/eyJgtB6ALOYhSD2\nStg/VGeT9uXmGdn3UmY4npZvsaCB2TXwBtYdB07k3VO8fqY87m5sdjjE1lt9IBJL\nbvz8kgsxkSqI4swoVdhO82zUN7EOE5/WYgntUm3IE/SMt7hZmdFPGUR1AoGBALip\nMeveYqOEZGTY4ToBgSPm7Hn9o5xXHLmgVbg1z17ymduBXXwXjBdLRS+hBMtsGTrO\naccRUljdGK8UiDhWAAFJsQX7AD+Bwky0co7mk3HbfvXuPZVrSwlFYcKErBePf27j\nB8oB7ZvmumWKDLkCv5oJYaYr3OenhCkT+pflcSlRAoGBAMHTOlv0NkLhWEiHTwO6\n7FniSiTGW69mcNnSFz3gAtzRYrhxywzILhmv9Z8N9OcBGenLaOeyFa/9vNAB87Tv\nWQXdYa2OQiTl7snX4UD8rOgQ5mP6qZCveZH2Op6BMvGsltcJpIgFTAi/59zYDR0H\nsAXGfBqRr2rE2xfKARVDZ7h/\n-----END PRIVATE KEY-----\n",
  "client_email": "user-595@flutterproject-391902.iam.gserviceaccount.com",
  "client_id": "111652184842407902755",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/user-595%40flutterproject-391902.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

  ''';
  final _gSheets = GSheets(credentials);
  static Worksheet? _worksheet;

  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gSheets.spreadsheet(spreadSheetId);
    _worksheet = ss.worksheetByIndex(0);
    countRows();
  }

  Future countRows() async {
    while ((await _worksheet!.values.value(column: 1, row: numberOfNotes + 1) !=
        '')) {
      numberOfNotes++;
    }
    loadNotes();
  }

  Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
      await _worksheet!.values.value(column: 1, row: i + 1);

      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }
    loading = false;
  }

  Future insert(String note) async {
    if (_worksheet == null) return;

    if (note.isNotEmpty) {
      numberOfNotes++;
      currentNotes.add(note);
      await _worksheet!.values.appendRow([note]);
    }
  }
  // Future deleteNote(int index) async{
  //   if (_worksheet == null) return;
  //
  //     return _worksheet!.deleteRow(index+2);
  //
  // }
}
