import firebase from "firebase/compat/app";

const firebaseConfig = {
  apiKey: "AIzaSyDgQsnSbfFDBc_uUDPcE7QQtuesDi1UBgM",
  authDomain: "flutternodejs.firebaseapp.com",
  projectId: "flutternodejs",
  storageBucket: "flutternodejs.appspot.com",
  messagingSenderId: "996518018972",
  appId: "1:996518018972:web:66644b089ce15691f6d259",
  measurementId: "G-W6SR59R7VX",
};
export default function firebaseClient() {
  if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
  }
}
