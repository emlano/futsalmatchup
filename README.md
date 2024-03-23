# Futsal MatchUp

A Futsal Team creation and stadium booking application.

## Description
An app aimed primarily at Futsal players, who have trouble finding players or organizing games, creating teams to do all that from a single app. It uses a ML method known as **Collaborative Recommendation** to make its recommendations to teams seeking players.

## Core Features
* User ratings
* Team creation
* Stadium booking
* Player recommendation

## Technologies

### Front End
* Uses [Flutter](https://flutter.dev/) for its wide range of platform compatibility and ease of use in creating modern looking UI.
* Flutter [Provider](https://pub.dev/packages/provider) package was used to manage state within the app.

### Back End
* Contains a [NodeJs](https://nodejs.org/en) server as a web server for handing API requests sent by the front end. 
* And a [Flask](https://flask.palletsprojects.com/en/3.0.x/) to host the Machine Learning algorithm responsible for making recommendations.

### Data Storage
* A mySQL database was used in order store information about users, stadiums, bookings and the teams created.

### Deployment
* [Docker](https://www.docker.com/) was used to [containerize](https://www.redhat.com/en/topics/cloud-native-apps/what-is-containerization) the back end components and make ready for deployment.
* [Google Cloud](https://cloud.google.com/?hl=en) is used to host the back end.
* Compute Engine API of Google Cloud was chosen specifically because of the need to store persistent data and its flexibility in services it offers.

## Installation

### Prerequisites
* Flutter
* Docker (Optional)
* Internet Connection

*Depending on the OS used, more dependacies may be required to install before running the application. In such cases, Flutter should notify you of thus.*

### Preparation
#### Method 1
* Download Flutter and make sure it has been added to your [`PATH`](https://windowsloop.com/how-to-add-to-windows-path/)
* Run command below in your terminal/console to check if it can be run.

```sh
$ flutter -v
```

* Download the repository and navigate to the `frontend` directory.
```sh
$ cd futsalmatchup/frontend/
```

* Run following command to start the application in your native operating system.
```sh
$ flutter run
```

#### Method 2
*This method assumes the back end is either not online or can not be contacted. As such, an experimental back end can be run to test the application*

* Download Docker and make sure it has been added to your PATH. This step also requires [docker-compose](https://docs.docker.com/compose/), Docker generally comes with docker-compose and thus no need to be downloaded separately.
* Navigate to the `backend` directory and run the following command to initialize the back end.
```sh
$ docker-compose up --build
```

* Alternatively, you can free up your shell window by detaching docker after it has initialized.
```sh
$ docker-compose up -d --build
```

* This command normally takes few minutes to download all the necessary dependency images and and set up the back end, **when run for the first time**.

* Follow the steps mentioned in **Method 1** afterwards.

* Backend would run till the system is shutdown if not stopped, so after running the application, run the following command to wind-down the back end and stop it gracefully.

**Note**: Back end will survive a `CTRL-C`, as such it is required that you run the following command when you want it to stop.
```sh
$ docker-compose down
```