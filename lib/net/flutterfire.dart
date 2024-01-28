import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is to weak.');
    } else if (e.code == 'email-already-in-use') {
      print('An account already exists for this email address');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    double value = double.parse(amount);

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
      } else {
        // Retrieve the existing amount and perform the addition
        double existingAmount =
            (snapshot.data()! as Map<String, dynamic>)['Amount'];
        double newAmount = existingAmount + value;

        // Update the document with the new amount
        transaction.update(documentReference, {'Amount': newAmount});
      }

      return true;
    });
  } catch (e) {
    print("Error adding coin: $e");
    return false;
  }

  return true;
}
