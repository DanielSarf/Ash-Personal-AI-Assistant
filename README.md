# Ash Personal AI Assistant

This project is currently a work in progress (WIP). The local large language model (LLM) intended to handle user prompts has not yet been implemented.

## Setup Instructions

To run this project, follow these steps:

1. **Set up a Flutter project**:
   - Create a Flutter project named `ash_personal_assistant`.

2. **Copy project files**:
   - Place the files from this repository into the project directory. Note that some files may be overridden.

3. **Log into Firebase**:
   - Log into Firebase within your Flutter project.

4. **Configure Firebase**:
   - Set up Firebase services, including Firebase Authentication (email, Google, Microsoft, and GitHub) and Firestore.

5. **Firestore Rules**:
   - Use the following Firestore rules:
     ```plaintext
     rules_version = '2';
     service cloud.firestore {
       match /databases/{database}/documents {
         match /users/{userId}/chats/{chatId}/messages/{messageId} {
           allow read, write: if request.auth.uid == userId;
         }
         match /users/{userId}/chats/{chatId} {
           allow read, write: if request.auth.uid == userId;
         }
       }
     }
     ```

6. **Download Authentication Icons**:
   - Download the Google, Microsoft, and GitHub icons, as they are not included in this repository. Place them in `assets/logos/`.
     - GitHub icon: `github_logo.svg`
     - Google icon: `google_logo.svg`
     - Microsoft icon: `microsoft_logo.svg`

7. **Run the App**:
   - Start the application.

## Flow of the App

<img width="1814" alt="Flow Chart" src="https://github.com/DanielSarf/Ash-Personal-AI-Assistant/assets/72676273/ad670d79-21b7-42d5-a3f2-b377db028880">


## Demo Video

[Watch the demo video](https://github.com/DanielSarf/Ash-Personal-AI-Assistant/assets/72676273/217b200c-d7dd-4994-99a2-297dae01fe81)
