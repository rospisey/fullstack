// const functions = require("firebase-functions");
// const admin = require("firebase-admin");
// admin.initializeApp();
// const userPrivacyPaths = require("./user_privacy.json");

// const db = admin.database();
// const firestore = admin.firestore();
// const realtime = admin.database();
// const storage = admin.storage();
// const FieldValue = admin.firestore.FieldValue;

// const exportDataBucket = userPrivacyPaths.exportDataUploadBucket;

const admin = require("firebase-admin");
admin.initializeApp();
const functions = require("firebase-functions");
const firestore = admin.firestore();
const realtime = admin.database();
const storage = admin.storage();

// const authFunction = require("./firebase/auth_function");
const databaseFunction = require("./firebase/database_function");
const firestoreFunction = require("./firebase/firestore_function");
const storageFunction = require("./firebase/storage_function");

// user trigger
exports.deleteUserDatabaseAndFirestore = functions.auth
  .user()
  .onDelete((user, context) => {
    const uid = user.uid;

    const databasePromise = databaseFunction.clearDatabaseUsers(uid);
    // const storagePromise = clearStorageData(uid);
    const firestorePromise = firestoreFunction.clearFirestoreData(uid);

    return Promise.all([
      databasePromise,
      firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

exports.createUsersDatabase = functions.firestore
  .document("users/{uid}")
  .onCreate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.data();

    const databasePromise = databaseFunction.createDatabaseUsers(
      context.params.uid,
      val
    );
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });
exports.updateUserPresenceFirestore = functions.database
  .ref("users/{uid}/presence")
  .onUpdate(async (change, context) => {
    // Get the data written to Realtime Database
    const isOnline = change.after.val();

    // Get a reference to the Firestore document
    const userStatusFirestoreRef = firestore.doc(`users/${context.params.uid}`);

    console.log(`status: ${isOnline}`);

    // Update the values on Firestore
    return userStatusFirestoreRef.update({
      presence: isOnline,
      lastSeenInEpoch: Date.now(),
    });
  });

// exports.updateUserPresenceDatabase = functions.firestore
//   .document("users/{uid}/presence")
//   .onUpdate(async (change, context) => {
//     // Get the data written to Realtime Database
//     const isOnline = change.after.data()["presence"];

//     // Get a reference to the Firestore document
//     const userStatusDatabaseRef = realtime.ref(`users/${context.params.uid}`);

//     console.log(`status: ${isOnline}`);

//     // Update the values on Firestore
//     return userStatusDatabaseRef.update({
//       presence: isOnline,
//       lastSeenInEpoch: Date.now(),
//     });
//   });

exports.updateUsersDatabase = functions.firestore
  .document("users/{uid}")
  .onUpdate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.after.data();

    const databasePromise = databaseFunction.updateDatabaseUsers(
      context.params.uid,
      val
    );
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

//books trigger
exports.createBooksDatabase = functions.firestore
  .document("books/{uid}")
  .onCreate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.data();

    const databasePromise = databaseFunction.createDatabaseBooks(
      context.params.uid,
      val
    );
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

exports.updateBooksDatabase = functions.firestore
  .document("books/{uid}")
  .onUpdate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.after.data();

    const databasePromise = databaseFunction.updateDatabaseBooks(
      context.params.uid,
      val
    );
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

exports.deleteBooksDatabase = functions.firestore
  .document("books/{uid}")
  .onDelete(async (snapshot, context) => {
    const uid = context.params.uid;

    const databasePromise = databaseFunction.clearDatabaseBooks(uid);
    const storagePromises = await admin
      .storage()
      .bucket()
      .deleteFiles({
        prefix: `books/${uid}`,
        function(err) {
          if (err) {
            console.log(err);
          } else {
            console.log(
              `All the Firebase Storage files in users/${userId}/ have been deleted`
            );
          }
        },
      });
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      storagePromises,
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });
