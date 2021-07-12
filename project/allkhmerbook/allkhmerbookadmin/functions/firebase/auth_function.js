const functions = require("firebase-functions");
const firestoreFunction = require("./firestore_function");
const databaseFunction = require("./database_function");

exports.clearUserData = functions.auth.user().onDelete((user) => {
  const uid = user.uid;

  const databasePromise = databaseFunction.clearDatabaseData(uid);
  // const storagePromise = clearStorageData(uid);
  const firestorePromise = firestoreFunction.clearFirestoreData(uid);

  return Promise.all([
    databasePromise,
    firestorePromise,
    // storagePromises
  ]).then(() => console.log(`Successfully removed data for user #${uid}.`));
});

// const replaceUID = (str, uid) => {
//   return str.replace(/UID_VARIABLE/g, uid);
// };
