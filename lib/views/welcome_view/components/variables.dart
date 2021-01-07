import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Variables for slidingup panel


FocusNode focusNodeUsername = FocusNode();
String hintTextUsername = 'Username';

FocusNode focusNodePassword = FocusNode();
String hintTextPassword = 'Password';

final TextEditingController passwordInput = new TextEditingController();
final TextEditingController usernameInput = new TextEditingController();