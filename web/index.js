// Import the functions you need from the SDKs you need
import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.5.0/firebase-app.js';
import { getAnalytics } from 'https://www.gstatic.com/firebasejs/9.5.0/firebase-analytics.js';
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
import { getAuth } from 'https://www.gstatic.com/firebasejs/9.5.0/firebase-auth.js';
import { getfirestore } from 'https://www.gstatic.com/firebasejs/9.5.0/firebase-firestore.js';

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyD0pMms-ZrtzAdw9GFK9MaSv0EtnMR1cdA",
  authDomain: "tournaments-example.firebaseapp.com",
  projectId: "tournaments-example",
  storageBucket: "tournaments-example.appspot.com",
  messagingSenderId: "247296152702",
  appId: "1:247296152702:web:659284aacf3ffb2e04f42f",
  measurementId: "G-08PKKEGNRF"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const db = getfirestore(app);
const auth = getAuth(app);