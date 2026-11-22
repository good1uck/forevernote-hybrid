# ForeverNote Hybrid

A Chrome page that summarizes one diary note with Firebase AI Logic hybrid inference.

The page tries Gemini Nano on the device first. If that model is not available, the same button uses the cloud model. The corner badge reads the path returned for that request: on-device or in the cloud.

The three notes are fictional samples. This repository does not contain a private diary.

## Try it

Open the hosted page in desktop Chrome:

https://forevernote-hybrid.web.app

1. Select one sample.
2. Click the summarize button.
3. In desktop Chrome with Gemini Nano, the badge shows the on-device path after the model is ready. In a browser without that model, the badge shows the cloud path.

## Run locally

Localhost cannot use the production reCAPTCHA key. App Check on localhost needs a debug token, and that token is not in this repository.

1. Copy `contest-prototype/local-config.example.js` to `contest-prototype/local-config.js`.
2. Set `appCheckDebugToken` to a token registered for the web app in Firebase App Check.
3. From `contest-prototype`, serve the folder over http, for example `python -m http.server 8765`.
4. Open `http://127.0.0.1:8765/` in desktop Chrome. Do not open the file directly.

## What the page uses

- Firebase project: `forevernote-hybrid`
- Firebase AI Logic, Gemini Developer API, `InferenceMode.PREFER_ON_DEVICE`
- Firebase App Check, enforced for Firebase AI Logic
- Firebase Hosting for the public page
