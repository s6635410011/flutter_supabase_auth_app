import 'package:flutter/material.dart';
import 'package:flutter_supabase_auth_app/services/auth.dart';
import 'package:flutter_supabase_auth_app/views/update_password_ui.dart';
 
class ForgotPasswordUi extends StatefulWidget {
  const ForgotPasswordUi({super.key});
 
  @override
  State<ForgotPasswordUi> createState() => _ForgotPasswordUiState();
}
 
class _ForgotPasswordUiState extends State<ForgotPasswordUi> {
  
  //สร้างตัวควบคุม
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
        ),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/images.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'ลืมรหัสผ่าน',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'เช่น sau@gmail.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ระบบจะส่ง OTP ไปยังอีเมล์ กรุณาตรวจสอบ ',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  //validate ui
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('กรุณากรอก Email'),
                      ),
                    );
                    return;
                  }
                  //reset password 
                  Auth().resetPassword(emailController.text);
                  //แล้วเปิดไปหน้า update password
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePasswordUi(),
                    ),
                  );
                },
                child: Text(
                  'รีเซ็ตรหัสผ่าน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
 
 