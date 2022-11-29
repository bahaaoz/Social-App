<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Custom amazing camera

## Features

Use camera to :

Take a picture
Record videos
Switch to front/back camera

## Getting started

Add this permission to AndroidManifest.xml

        <uses-permission android:name="android.permission.CAMERA" />
        <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

## Usage

you must get permission (Storage, Camera) and create array of CameraDescription object to passed it to package

## Additional information
