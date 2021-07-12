const functions = require("firebase-functions");
const admin = require("firebase-admin");

const userPrivacyPaths = require("../user_privacy.json");
const FieldValue = admin.firestore.FieldValue;
const firestore = admin.firestore();

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

const replaceUID = (str, uid) => {
  return str.replace(/UID_VARIABLE/g, uid);
};

module.exports = { clearFirestoreData, createFirestoreData };
