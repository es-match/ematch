import 'package:ematch/OwnerApp/model/userModel.dart';
import 'package:ematch/OwnerApp/repository/userRepository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
UserRepository userRepository = UserRepository();
String my_shortname; //first name
String my_name;
String my_email;
String my_imageurl;
String my_userid;
String my_role; // standard or owner
String my_method; // email or google

Future<String> signInWithGoogle() async {
  try {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (await createOrGetUserInDb(user, 'google', user.displayName)) {
      print('signInWithGoogle succeeded: $user');
      return '$user';
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<User> signin(String email, String password, BuildContext context) async {
  try {
    await Firebase.initializeApp();
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = authResult.user;

    if (await createOrGetUserInDb(user, 'email', '')) {
      print('signInWithEmail succeeded: $user');
      return Future.value(user);
    } else {
      return Future.value(null);
    }
  } catch (e) {
    // simply passing error code as a message
    print(e.code);
    switch (e.code) {
      case 'invalid-email':
        showErrDialog(context, 'E-mail inválido');
        break;
      case 'invalid-password':
        showErrDialog(context, 'Senha incorreta.');
        break;
      case 'user-not-found':
        showErrDialog(context,
            "E-mail não registrado, registre uma nova conta em sign up");
        break;
      case 'ERROR_USER_DISABLED':
        showErrDialog(context, e.code);
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        showErrDialog(context, e.code);
        break;
      case 'operation-not-allowed':
        showErrDialog(context,
            'Descupe nossos serviços estão indisponíveis, tente novamente mais tarde.');
        break;
      default:
        showErrDialog(context, e.code);
    }
    // since we are not actually continuing after displaying errors
    // the false value will not be returned
    // hence we don't have to check the valur returned in from the signin function
    // whenever we call it anywhere
    return Future.value(null);
  }
}

// change to Future<FirebaseUser> for returning a user
Future<User> signUp(
    String email, String password, String name, BuildContext context) async {
  try {
    await Firebase.initializeApp();
    UserCredential authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = authResult.user;

    if (await createOrGetUserInDb(user, 'email', name)) {
      print('signInWithEmail succeeded: $user');
      return Future.value(user);
    } else {
      return Future.value(null);
    }

    // return Future.value(true);
  } catch (error) {
    switch (error.code) {
      case 'email-already-in-use':
        showErrDialog(context, "Email já em uso");
        break;
      case 'invalid-email':
        showErrDialog(context, "Endereço de e-mail inválido");
        break;
      case 'error-weak-password':
        showErrDialog(context, "Por favor selecione uma senha mais forte.");
        break;
    }
    return Future.value(null);
  }
}

Future<bool> signOutUser() async {
  await Firebase.initializeApp();
  // User user = _auth.currentUser;
  // print(user.providerData[1].providerId);
  // if (user.providerData[1].providerId == 'google.com') {
  //   await googleSignIn.disconnect();
  // }
  if (my_method == 'google') {
    await googleSignIn.disconnect();
  }
  await _auth.signOut();
  print("User Signed Out");
  return Future.value(true);
}

showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

Future<bool> createOrGetUserInDb(
    User user, String methodForm, String name) async {
  try {
    UserModel userModel;
    if (methodForm == 'google') {
      userModel = await userRepository.getUserByGoogleToken(user.uid);
      if (userModel == null) {
        userModel = new UserModel();
        userModel.googleToken = user.uid;
        userModel.emailToken = null;
        userModel.userName = user.displayName;
        userModel.userEmail = user.email;
        userModel.imageUrl = user.photoURL;
        userModel.role = 'Standard';
        userModel = await userRepository.insertUser(userModel);
      }
    } else {
      userModel = await userRepository.getUserByEmailToken(user.uid);
      if (userModel == null) {
        userModel = new UserModel();
        userModel.googleToken = null;
        userModel.emailToken = user.uid;
        userModel.userName = name;
        userModel.userEmail = user.email;
        userModel.imageUrl =
            'https://firebasestorage.googleapis.com/v0/b/esmatch-ce3c9.appspot.com/o/Default%20Images%2Fblank_user.png?alt=media&token=5b908d38-c462-44a0-b119-70b06b8b310c';
        userModel.role = 'Standard';
        userModel = await userRepository.insertUser(userModel);
      }
    }

    if (userModel != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      assert(userModel.userEmail != null);
      assert(userModel.userName != null);
      assert(userModel.imageUrl != null);

      // Store the retrieved data
      my_shortname = userModel.userName;
      my_name = userModel.userName;
      my_email = userModel.userEmail;
      my_imageurl = userModel.imageUrl;
      my_userid = userModel.id;
      my_role = userModel.role;
      my_method = methodForm;
      // Only taking the first part of the name, i.e., First Name
      if (my_shortname.contains(" ")) {
        my_shortname = my_shortname.substring(0, my_shortname.indexOf(" "));
      }
    }
    return true;
  } catch (e) {
    return false;
  }
}
