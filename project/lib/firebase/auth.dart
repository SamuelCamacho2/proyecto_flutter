// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_auth/firebase_auth.dart';

// class EmailAuth {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   static const String CLIENT_ID = "1909009eb9d726bcead9";
//   static const String CLIENT_SECRET = "821e85e421bc3c9be90e28acde837e9b4fe90507";

//   Future<bool> createUser(
//       {required String emailUser, required String pwdUser}) async {
//     try {
//       final credentials = await auth.createUserWithEmailAndPassword(
//           email: emailUser, password: pwdUser);
//       credentials.user!.sendEmailVerification();
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> validateUser({required String emailUser, required String pwdUser}) async {
//     try {
//       final credentials = await auth.signInWithEmailAndPassword(
//           email: emailUser, password: pwdUser);
//       if (credentials.user!.emailVerified) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   // Future<User> signInWithGithub(String code) async {
//   //   final response = await http.post("https://github.com/login/oauth/access_token" as Uri,
//   //     headers: {
//   //       "Content-Type": "application/json",
//   //       "Accept": "application/json"
//   //     },
//   //     body: jsonEncode(GitHubLoginRequest(
//   //       clientId: CLIENT_ID,
//   //       clientSecret: CLIENT_SECRET,
//   //       code: code,
//   //     )),
//   //   );

//   //   GitHubLoginResponse loginResponse =
//   //       GitHubLoginResponse.fromJson(json.decode(response.body));

//   //   final AuthCredential credential =
//   //       GithubAuthProvider.credential(loginResponse.accessToken!);

//   //   final User user = (await auth.signInWithCredential(credential)).user!;
//   //   return user;
//   // }
  
//   Future signOut() async {
//     auth.signOut();
//     }
  
// }