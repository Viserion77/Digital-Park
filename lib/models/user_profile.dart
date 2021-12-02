import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  late String email;
  late String? username;
  late String? fullName;
  late String? photoUrl;
  late String? providerId;
  late String? password; // because web system needs it
  late List? roles;
  late Timestamp? birthDate;
  late String? genre;
  late bool? active; // because web system needs it
  late double? focusActivity = 0.5;

  UserProfile(
    this.email, {
    this.username,
    this.fullName,
    this.photoUrl,
    this.providerId,
    this.birthDate,
    this.genre,
    this.roles,
    this.active,
    this.focusActivity,
    this.password,
  });

  @override
  String toString() {
    return 'UserProfile{email: $email,'
        ' username: $username,'
        ' fullName: $fullName,'
        ' photoUrl: $photoUrl,'
        ' providerId: $providerId,'
        ' roles: $roles,'
        ' birthDate: $birthDate,'
        ' genre: $genre,'
        ' active: $active,'
        ' password: $password,'
        ' focusActivity: $focusActivity}';
  }

  factory UserProfile.fromSnapshot(DocumentSnapshot? userDocument) {
    if (userDocument!.data() == null) {
      return UserProfile.fromCurrentUser();
    }

    final Map userData = userDocument.data() as Map<dynamic, dynamic>;

    if (userData['providerId'] == null) {
      userData['providerId'] =
          FirebaseAuth.instance.currentUser!.providerData.isEmpty
              ? 'password'
              : FirebaseAuth.instance.currentUser!.providerData[0].providerId;
    }

    return UserProfile(userDocument.id,
        username: userData['username'],
        active: userData['active'],
        fullName: userData['fullName'],
        photoUrl: userData['photoUrl'],
        providerId: userData['providerId'],
        birthDate: userData['birthDate'],
        genre: userData['genre'],
        roles: userData['roles'],
        password: userData['password'],
        focusActivity: userData['focusActivity']);
  }

  factory UserProfile.fromCurrentUser() {
    return UserProfile(FirebaseAuth.instance.currentUser!.email.toString(),
        username: FirebaseAuth.instance.currentUser!.displayName,
        photoUrl: FirebaseAuth.instance.currentUser!.photoURL,
        providerId: FirebaseAuth.instance.currentUser!.providerData.isEmpty
            ? null
            : FirebaseAuth.instance.currentUser!.providerData[0].providerId,
        roles: [FirebaseFirestore.instance.collection('roles').doc('usuario')]);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email, // because web system needs it
        'fullName': fullName,
        'photoUrl': photoUrl,
        'active': active,
        'providerId': providerId,
        'roles': roles,
        'birthDate': birthDate,
        'genre': genre,
        'password': password,
        'focusActivity': focusActivity,
      };
}
