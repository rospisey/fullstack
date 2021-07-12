const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const userPrivacyPaths = require("./user_privacy.json");

const db = admin.database();
const firestore = admin.firestore();
const realtime = admin.database();
const storage = admin.storage();
const FieldValue = admin.firestore.FieldValue;

const exportDataBucket = userPrivacyPaths.exportDataUploadBucket;

exports.rtChangePresence = functions.database
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

exports.cfChangePresence = functions.firestore
  .document("users/{uid}/presence")
  .onUpdate(async (change, context) => {
    // Get the data written to Realtime Database
    const isOnline = change.after.data()["presence"];

    // Get a reference to the Firestore document
    const userStatusDatabaseRef = realtime.ref(`users/${context.params.uid}`);

    console.log(`status: ${isOnline}`);

    // Update the values on Firestore
    return userStatusDatabaseRef.update({
      presence: isOnline,
      lastSeenInEpoch: Date.now(),
    });
  });

// exports.batchUpdate = functions.firestore
//   .document("batch/{triggerId}")
//   .onCreate((snap, context) => {
//     var collecRef = firestore.collection("users");
//     return collecRef.get().then((snapshot) => {
//       const ts = admin.database.ServerValue.TIMESTAMP;
//       let batch = firestore.batch();

//       snapshot.forEach((doc) => {
//         const ref = doc.ref;

//         batch.update(ref, {
//           lastUpdate: ts,
//         });
//       });

//       return batch.commit();
//     });
//   });

// exports.sendByeEmail = functions.auth.user().onDelete((user) => {
//   return firestore
//     .document(`users/${user.uid}`)
//     .delete()
//     .then((snap) => {
//       return functions.database.ref(`users/${user.uid}`).delete();
//     });
// });

exports.clearUserData = functions.auth.user().onDelete((user) => {
  const uid = user.uid;

  const databasePromise = clearDatabaseData(uid);
  // const storagePromise = clearStorageData(uid);
  const firestorePromise = clearFirestoreData(uid);

  return Promise.all([
    databasePromise,
    firestorePromise,
    // storagePromises
  ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
});

// exports.onCreateData = functions.auth.user().onCreate((user) => {
//   const uid = user.uid;

//   // const databasePromise = createDatabaseData(uid);
//   // const storagePromise = clearStorageData(uid);
//   // const firestorePromise = createFirestoreData(uid);

//   return Promise.all([
//     // databasePromise,
//     // firestorePromise,
//     // storagePromises
//   ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
// });

exports.onChangeRtUsers = functions.firestore
  .document("users/{uid}")
  .onCreate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.data();

    const databasePromise = createDatabaseData(context.params.uid, val);
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

exports.onChangeRtContents = functions.firestore
  .document("users/{uid}")
  .onCreate((snapshot, context) => {
    const uid = context.params.uid;
    const val = snapshot.data();

    const databasePromise = createDatabaseData(context.params.uid, val);
    // const storagePromise = clearStorageData(uid);
    // const firestorePromise = createFirestoreData(uid);

    return Promise.all([
      databasePromise,
      // firestorePromise,
      // storagePromises
    ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
  });

// Delete data from all specified paths from the Realtime Database. To add or
// remove a path, edit the `database[clearData]` array in `user_privacy.json`.
//
// This function is called by the top-level `clearData` function.
//
// Returns a list of Promises
const clearDatabaseData = (uid) => {
  const paths = userPrivacyPaths.database.clearData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const path = replaceUID(paths[i], uid);
    promises.push(
      db
        .ref(path)
        .remove()
        .catch((error) => {
          // Avoid execution interuption.
          console.error("Error deleting data at path: ", path, error);
        })
    );
  }

  return Promise.all(promises).then(() => uid);
};

const createDatabaseData = (uid, val) => {
  const paths = userPrivacyPaths.database.createData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const path = replaceUID(paths[i], uid);

    promises.push(
      db
        .ref(path)
        .set(val)
        .catch((error) => {
          // Avoid execution interuption.
          console.error("Error deleting data at path: ", path, error);
        })
    );
  }

  return Promise.all(promises).then(() => uid);
};

// Clear all specified files from the Realtime Database. To add or remove a
// path, edit the `storage[clearData]` array in `user_privacy.json`.
//
// This function is called by the top-level `clearData` function.
//
// Returns a list of Promises
const clearStorageData = (uid) => {
  const paths = userPrivacyPaths.storage.clearData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const bucketName = replaceUID(paths[i][0], uid);
    const path = replaceUID(paths[i][1], uid);
    const bucket = storage.bucket(bucketName);
    const file = bucket.file(path);
    promises.push(
      file.delete().catch((error) => {
        console.error("Error deleting file: ", path, error);
      })
    );
  }

  return Promise.all(promises).then(() => uid);
};

// Clear all specified paths from the Firestore Database. To add or remove a
// path, edit the `firestore[clearData]` array in `user_privacy.json`.
//
// This function is called by the top-level `clearData` function.
//
// Returns a list of Promises
const clearFirestoreData = (uid) => {
  const paths = userPrivacyPaths.firestore.clearData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const entry = paths[i];
    const entryCollection = replaceUID(entry.collection, uid);
    const entryDoc = replaceUID(entry.doc, uid);
    const docToDelete = firestore.collection(entryCollection).doc(entryDoc);
    if ("field" in entry) {
      const entryField = replaceUID(entry.field, uid);
      const update = {};
      update[entryField] = FieldValue.delete();
      promises.push(
        docToDelete.update(update).catch((err) => {
          console.error("Error deleting field: ", err);
        })
      );
    } else if (docToDelete) {
      promises.push(
        docToDelete.delete().catch((err) => {
          console.error("Error deleting document: ", err);
        })
      );
    }
  }

  return Promise.all(promises).then(() => uid);
};

const createFirestoreData = (uid) => {
  const paths = userPrivacyPaths.firestore.createData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const entry = paths[i];
    const entryCollection = replaceUID(entry.collection, uid);
    const entryDoc = replaceUID(entry.doc, uid);
    const docToCreate = firestore.collection(entryCollection).doc(entryDoc);
    if ("field" in entry) {
      const entryField = replaceUID(entry.field, uid);
      const update = {};
      update[entryField] = FieldValue.delete();
      promises.push(
        docToCreate.update(update).catch((err) => {
          console.error("Error deleting field: ", err);
        })
      );
    } else if (docToCreate) {
      promises.push(
        docToCreate
          .set({
            timestamp: Date.now(),
          })
          .catch((err) => {
            console.error("Error deleting document: ", err);
          })
      );
    }
  }

  return Promise.all(promises).then(() => uid);
};

const replaceUID = (str, uid) => {
  return str.replace(/UID_VARIABLE/g, uid);
};
