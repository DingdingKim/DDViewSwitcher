
DDViewSwitcher
===================

## Introduction
Hello !! 😊
With DDViewSwitcher, you can simply implement the effect of scrolling the view with just two lines. 
Like android's TextSwitcher or realtime ranking UI(text scroll up animaiton repeatedly.)

## Demo

![Sample Main menu](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/main.gif)
![DDTextSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/textSwitcher.gif)
![DDImageSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/imageViewSwitcher.gif)
![DDTextSwitcher(Manually)](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/manualTextSwitcher.gif)
![DDViewSwitcher](https://github.com/DingdingKim/DDViewSwitcher/blob/master/Screenshot/viewSwitcher.gif)

## Installation

### CocoaPods

DDViewSwitcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DDViewSwitcher"
```

## Usage

Just three line!

```Swift

//**************************************************
//  This code is simplest way to make DDTextSwitcher !
//  You want to change attributes and more detail, look other ViewController in this sample !
//**************************************************

let textSwitcher = DDTextSwitcher(frame: self.view.bounds, data: ["item 1", "item 2"], scrollDirection: .vertical)
self.view.addSubview(textSwitcher)
textSwitcher.start()

```

## Author

Dingding Kim, twlovesh89@gmail.com

## License

DDViewSwitcher is available under the MIT license. See the LICENSE file for more info.
