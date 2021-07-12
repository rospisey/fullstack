const functions = require("firebase-functions");
const admin = require("firebase-admin");

const userPrivacyPaths = require("../user_privacy.json");
const db = admin.database();

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

const replaceUID = (str, uid) => {
  return str.replace(/UID_VARIABLE/g, uid);
};

module.exports = { createDatabaseData, clearDatabaseData };
