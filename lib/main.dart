import 'package:flutter/material.dart';
import 'package:flutter_supabase_auth_app/views/login_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tabffthroxdygyhzitbc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRhYmZmdGhyb3hkeWd5aHppdGJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQwNjQzOTAsImV4cCI6MjA4OTY0MDM5MH0.Vwybi4WfmAfe99_mMhI3AamS5DfmQYabrH48CXE2-Lg',
  );
  runApp(
  flutterSupavaseAuthApp());
}

class flutterSupavaseAuthApp extends StatefulWidget {
  const flutterSupavaseAuthApp({super.key});

  @override
  State<flutterSupavaseAuthApp> createState() => _flutterSupavaseAuthAppState();
}

class _flutterSupavaseAuthAppState extends State<flutterSupavaseAuthApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}

