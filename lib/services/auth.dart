//ไฟล์นี้จะทำงานกับ supabase ในส่วนของ การลงทะเบียน การเข้าสู่ระบบ และการรีเซ็ตรหัสผ่าน authentication
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  //สร้าง (ตัวแทน)instance ของ SupabaseClient เพื่อเชื่อมต่อกับ Supabase
  final SupabaseClient supabase = Supabase.instance.client;
  //ฟังก์ชันสำหรับการลงทะเบียนผู้ใช้ใหม่ signup
  Future<String?> signup(String email, String password) async {
    //try-catch
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return 'success';
      }
    } catch (ex) {
      return "Error: $ex";
    }
  }
//ฟังก์ชันสำหรับการเข้าสู่ระบบ login
  Future<String?> login(String email, String password) async {
    //try-catch
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return 'success';
      }
    } catch (ex) {
      return "Error: $ex";
    }
  }

  // log out
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  //ฟังก์ชันสำหรับการรีเซ็ตรหัสผ่าน reset password
  Future<String?> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return 'success';
    } catch (ex) {
      return "Error: $ex";
    }
  }

  // update new password
  Future<String?> updatePassword(
      String token, String newPassword, String email) async {
    try {
      final recovery = await supabase.auth.verifyOTP(
        email: email,
        token: token,
        type: OtpType.recovery,
      );

      await supabase.auth.updateUser(
        UserAttributes(
          password: newPassword,
        ),
      );

      return 'success';
    } catch (ex) {
      return "Error: $ex";
    }
  }
}
