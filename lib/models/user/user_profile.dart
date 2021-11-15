import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  late String email;
  late String? username;
  late String? fullName;
  late String? photoUrl;
  late String? providerId;
  late List? roles;
  late DateTime? birthDate;
  late String? genre;
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
    this.focusActivity,
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
        ' focusActivity: $focusActivity}';
  }

  factory UserProfile.fromSnapshot(DocumentSnapshot? userDocument) {
    if (userDocument!.data() == null) {
      return UserProfile.fromCurrentUser();
    }

    final Map userData = userDocument.data() as Map<dynamic, dynamic>;
    print('userDatauserDatauserDatauserData');
    print(userData);
    return UserProfile(userDocument.id,
        username: userData['username'],
        fullName: userData['fullName'],
        photoUrl: userData['photoUrl'],
        providerId: userData['providerId'],
        birthDate: userData['birthDate'],
        genre: userData['genre'],
        roles: userData['roles'],
        focusActivity: userData['focusActivity']);
  }

  factory UserProfile.fromCurrentUser() {
    return UserProfile(FirebaseAuth.instance.currentUser!.email.toString(),
        username: FirebaseAuth.instance.currentUser!.displayName,
        photoUrl: FirebaseAuth.instance.currentUser!.photoURL,
        providerId:
            FirebaseAuth.instance.currentUser!.providerData[0].providerId,
        roles: [FirebaseFirestore.instance.collection('roles').doc('usuario')]);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'fullName': fullName,
        'photoUrl': photoUrl,
        'providerId': providerId,
        'roles': roles,
        'birthDate': birthDate,
        'genre': genre,
        'focusActivity': focusActivity,
      };
}
