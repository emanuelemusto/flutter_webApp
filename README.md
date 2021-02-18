# Flutter Application for a HAPI-FHIR Server

## How to Use 
 
### Step 1

Download or clone this repo by using the link below: change ip and port in file constant.dart

https://github.com/emanuelemusto/flutter_webApp.git

and install flutter

[Flutter Install] [FLUTTER]

install Android Studio

[Android Studio download][ANDROIDSTUDIO]

### Step 2

Go to project root and execute the following command in console to get the required dependencies:
```sh
flutter pub get
```
### Step 3

 _set your ip and server port on file constant.dart_


### Step 4

Set up web support Run the following commands to use the latest version of the Flutter SDK from the beta channel and enable web support:
```sh
flutter channel beta flutter build cd /build/web flutter upgrade flutter config --enable-web
```

for using remote web verison using following commands:
```sh
flutter build web cd /build/web python3 -m http.server 8000
```

### Step 5

To create apk using command: 
```sh
flutter build apk
```

run the following command (if you want run on browser): 
```sh
flutter run -d chrome
```


Login with `mario`,`rossi` for be a Patient or with `giuseppe`,`verdi` for be a Doctor.

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [FLUTTER]: <https://flutter.dev/docs/get-started/install>
   [ANDROIDSTUDIO]: <https://developer.android.com/studio>
