class ApiEndPoints {
  static const String baseurl = 'http://www.oh-kang.kro.kr:7288/';
  static const String localhost = 'http://localhost:3000/';
  static _ApiEndPoints apiEndPoints = _ApiEndPoints();
}

class _ApiEndPoints {
  final String loginid = 'authaccount/login';
  final String checkkakao = 'authaccount/login/checkKaKaoEnrolled';
  final String checkgoogle = 'authaccount/login/checkGoogleEnrolled';
  final String registerid = 'authaccount/registration';
  final String getpicPath = 'authaccount/getpic';

  final String ai_test = 'test';
}
