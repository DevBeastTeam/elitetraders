# Fixing Image Upload Issues 🖼️

Agar image upload nahi ho rahi, to ye checks karein:

## 1. App Restart
Maine `AndroidManifest.xml` mein permissions add ki hain. Please app ko **poora band karke dobara chalayen** (Stop and Run again), taaki nayi permissions apply hon.

## 2. Firebase Storage Rules
Agar phir bhi error aaye, to ho sakta hai Firebase Storage locked ho.
Firebase Console mein **Storage** > **Rules** mein jayen aur ye rules paste karein:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```
Isse logged-in users ko image upload karne ki permission mil jayegi.

## 3. Check Internet
Make sure karein ke device/emulator par internet chal raha hai.
