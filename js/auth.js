

var firebaseConfig = {
    apiKey: "AIzaSyAHurVl-P1ztW5743Kl131GU2d9Jf20UJg",
    authDomain: "attendance-record-system.firebaseapp.com",
    projectId: "attendance-record-system",
    storageBucket: "attendance-record-system.appspot.com",
    messagingSenderId: "609250890510",
    appId: "1:609250890510:web:393726c49abbffb949bd5f"
};
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    const db = firebase.firestore();
    db.settings({timestampsInSnapshots: true});