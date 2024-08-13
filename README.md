# Social Media App

A full-featured social media application built using flutter. This app allows users to register, login, create posts, comment on posts, and follow other users. It also supports profile management and displays users' posts with comments and likes.

## Features

- **User Authentication**: Register and login with JWT-based authentication.
- **Create Posts**: Users can create posts with a title, description, and image.
- **Comments**: Users can comment on posts, with comments being displayed along with the username and profile picture of the commenter.
- **Follow System**: Users can follow each other and see updates from users they follow.
- **Responsive API**: Built with REST principles and designed to be easily integrated with any frontend.
## Installation and Setup

### Prerequisites

- [Node.js](https://nodejs.org/en/) (v14+)
- [MongoDB](https://www.mongodb.com/) (Ensure MongoDB is running locally or provide a MongoDB URI)
- [flutter](https://docs.flutter.dev/get-started/install)

### Setup Instructions

1. **Clone the repository**

    ```bash
    git clone git@github.com:musjib999/benmo_challange.git
    cd benmo_challange
    ```
2. **Start Server**
    ```bash
        cd server
        npm start
    ```
3. **Run Mobile Application**

    ```bash
    cd ..
    cd mobile_app
    flutter run
    ```