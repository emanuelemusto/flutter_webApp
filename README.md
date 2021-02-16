How to Use
Step 1:

Download or clone this repo by using the link below:
change ip and port in file constant.dart

https://github.com/emanuelemusto/flutter_webApp.git

and install flutter

https://flutter.dev/docs/get-started/install

install Android Studio

Step 2:

Go to project root and execute the following command in console to get the required dependencies:

flutter pub get 

set your ip and server port on file constant.dart

Step 3:

Set up web support
Run the following commands to use the latest version of the Flutter SDK from the beta channel and enable web support:

flutter channel beta
flutter build
cd /build/web
flutter upgrade
flutter config --enable-web

for using remote web verison using following commands:
flutter build web
cd /build/web
python3 -m http.server 8000

Step 4:
to create apk using command: flutter build apk

run the following command: "flutter run -d chrome" if you want run on browser

Login with "mario","rossi" for be a Patient or with "giuseppe","verdi" for be a Doctor.
