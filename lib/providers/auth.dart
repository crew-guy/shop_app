import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

const WEB_API_KEY = 'AIzaSyAhvn-Ig5Y9NoNnvBrqTm4RcpM590bxzkI';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryToken;
  String? _userId;

  Future<void> _authenticate(
    String email,
    String password,
    String urlKey,
  ) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlKey}?key=${WEB_API_KEY}');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        // print(responseData['error']['message']);
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
