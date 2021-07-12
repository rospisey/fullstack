const functions = require("firebase-functions");
const admin = require("firebase-admin");

const userPrivacyPaths = require("../user_privacy.json");
const storage = admin.storage();

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

const replaceUID = (str, uid) => {
  return str.replace(/UID_VARIABLE/g, uid);
};
