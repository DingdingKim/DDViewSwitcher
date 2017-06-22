
DDViewSwitcher
===================

## Introduction
Hello !! 😊
With DDViewSwitcher, you can simply implement the effect of scrolling the view with just two lines. 
Like android's TextSwitcher or realtime ranking UI(text scroll up animaiton repeatedly.)

## Demo

![Sample Main menu](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/main_320.gif)
![DDTextSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/textSwitcher_320.gif)
![DDImageSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/imageSwitcher_320.gif)
![DDTextSwitcher(Manually)](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/manualTextSwitcher_320.gif)
![DDViewSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/viewSwitcher_320.gif)

## Installation

### CocoaPods

DDViewSwitcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DDViewSwitcher"
```

## Usage

Just two line!

```Swift

//**************************************************
//  This code is simplest way to make DDTextSwitcher !
//  You want to change attributes and more detail, look other ViewController in this sample !
//**************************************************

let textSwitcher = DDTextSwitcher(frame: viewForSwitcher.bounds, data: arrData, scrollDirection: .vertical)
viewForSwitcher.addSubview(textSwitcher)

```

## Author

Dingding Kim, twlovesh89@gmail.com

## License

DDViewSwitcher is available under the MIT license. See the LICENSE file for more info.
