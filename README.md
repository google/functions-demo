# Firebase Functions Demo

- Using Firebase Functions with an external API (Walmart)

- Consuming Firebase Realtime Database/Functions in an iOS app using FirebaseUI

Note: this is not an official Google product.

## Prerequisites

1. A gmail account

2. Billing enabled in the GCP Console (https://console.developers.google.com/)

   _You might be eligible for a free trial with a $300, 12-month credit_

3. A Walmart Open API key

   _Register at https://developer.walmartlabs.com/_

4. Node.js, npm and Firebase CLI installed

   _npm install -g firebase-tools_


## Setting up

1. Using the Firebase Console (https://console.firebase.google.com), create a new project

2. Upgrade the pricing plan to Blaze (Pay as you go)

3. Log into the Firebase CLI

   _firebase login_

4. In the terminal, navigate to the root of this repository

5. Initialize the Firebase Functions

   _firebase init functions_

   _When prompted, select the project created in step #1._

   _Do not overwrite existing files._

   _Say "Y" to "Do you want to install dependencies"_

6. cd functions

7. Edit the walmartAPI.js file and update the WALMART_API_KEY constant with your key

8. Deploy the functions

   _firebase deploy --only functions_

9. In the Firebase Console, use the Database Rules to make the database public

    (Caution - this is only good for demo purposes, do not leave a production database public)

    {
      "rules": {
        ".read": true,
        ".write": true
      }
    }

10. In the Firebase Console, go through the "Add Firebase to your iOS App" wizard

11. Enter "com.github.davidair.FunctionsDemo" as the iOS Bundle ID

12. Download GoogleService-Info.plist

13. In the FunctionsDemo directory, run "pod install"

14. Open FunctionsDemo.xcworkspace

15. Drag the GoogleService-Info.plist downloaded in step 12 into the project

You should be able to run the demo in the simulator
