# vgs-show-ios
VGS Show Sample for iOS


## Table of contents
- [Overview](#overview)
- [Getting started](#getting-started)
- [Parameters](#parameters)
- [Tooling](#tooling)
- [API Reference](#api-reference)
- [Packages](#third-party-libraries)


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
1. Launch `Xcode` and open the project `vgs-show-ios/VGSShow.xcodeproj`
2. Run in Simulator
```

## Parameters

In order to start the project we need below parameters. All fields are mandatory

- VGS Vault ID : Talk to our solutions team (solutions@solidfi.com) to get the ID via a secured method. (It will different based on sandbox and live)
- Card ID : Id of your card
- VGS Show Token : You will get it from the "/show-token" api from the backend
- Environment :  Select live or sandbox environment

Notes: VGS Token can be used only once to get data. You need to call "/show-token" api to generate new VGS Token    

## Tooling
- iOS 13.0 +
- Xcode 11 +
- Swift 5.0 +

## API Reference
- VGS Show Integration : https://www.verygoodsecurity.com/docs/vgs-show/ios-sdk
- Solid API Integration : https://documenter.getpostman.com/view/13543869/TWDfEDwX#ce8c0e57-0dcf-45ea-87d8-6f03a302e027

## Packages
- VGSShowSDK
- IQKeyboardManager

