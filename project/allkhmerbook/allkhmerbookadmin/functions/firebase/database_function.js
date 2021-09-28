const functions = require("firebase-functions");
const admin = require("firebase-admin");

const userPrivacyPaths = require("../user_privacy.json");
const db = admin.database();

//Users
const createDatabaseUsers = (uid, val) => {
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
const clearDatabaseUsers = (uid) => {
  const paths = userPrivacyPaths.database.createData;
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

const updateDatabaseUsers = (uid, val) => {
  const paths = userPrivacyPaths.database.createData;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const path = replaceUID(paths[i], uid);

    promises.push(
      db
        .ref(path)
        .update(val)
        .catch((error) => {
          // Avoid execution interuption.
          console.error("Error deleting data at path: ", path, error);
        })
    );
  }

  return Promise.all(promises).then(() => uid);
};

//Books
const createDatabaseBooks = (uid, val) => {
  const paths = userPrivacyPaths.database.createBooks;
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

const updateDatabaseBooks = (uid, val) => {
  const paths = userPrivacyPaths.database.createBooks;
  const promises = [];

  for (let i = 0; i < paths.length; i++) {
    const path = replaceUID(paths[i], uid);

    promises.push(
      db
        .ref(path)
        .update(val)
        .catch((error) => {
          // Avoid execution interuption.
          console.error("Error deleting data at path: ", path, error);
        })
    );
  }

  return Promise.all(promises).then(() => uid);
};
const clearDatabaseBooks = (uid) => {
  const paths = userPrivacyPaths.database.clearBooks;
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
const replaceUID = (str, uid) => {
  return str.replace(/UID_VARIABLE/g, uid);
};

module.exports = {
  createDatabaseUsers,
  clearDatabaseUsers,
  updateDatabaseUsers,
  createDatabaseBooks,
  updateDatabaseBooks,
  clearDatabaseBooks,
};
