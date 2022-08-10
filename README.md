# vgs-show-ios
VGS Show Sample for iOS


## Table of contents
- [Overview](#overview)
- [Getting started](#getting-started)
- [Parameters](#parameters)
- [Tooling](#tooling)
- [Packages](#third-party-libraries)
- [API Reference](#api-reference)


## Overview
VGS Show is the way to display sensitive data to an “end-user” without needing to pass through your systems.

## Getting started
Configure VGSShow Sample :
- Clone repository
```groovy
git clone git@github.com:solidfi/vgs-show-ios.git 
OR
git clone https://github.com/solidfi/vgs-show-ios.git
```
- Open project and run in Simulator
```groovy
1. Launch `Xcode` and open the project `vgs-show-ios-main/VGSShow/VGSShow.xcodeproj`
2. Run in Simulator
```

## Parameters

In order to start the project we need below parameters. All fields are mandatory

- VGS Vault ID : The VGS vault ID's required for implementing the sample code can be requested via a Solid Help desk ticket.
- Card ID : Id of your card
- VGS Show Token : You will get it from the "/show-token" api from the backend
- Environment :  Select live or sandbox environment

Notes: VGS Show Token can be used only once to get data. You need to call "/show-token" api to generate new VGS Token    

## Tooling
- iOS 13.0 +
- Xcode 11 +
- Swift 5.0 +

## Packages
- VGSShowSDK
- IQKeyboardManager


## API Reference
- VGS Show Integration : https://www.verygoodsecurity.com/docs/vgs-show/ios-sdk
- Solid API Integration : https://www.solidfi.com/docs/introduction
