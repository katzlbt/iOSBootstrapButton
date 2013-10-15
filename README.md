#BButton 2.0 Forked

BButton is a subclass of UIButton that looks like the [Twitter Bootstrap 2.3.1](http://twitter.github.com/bootstrap) buttons.
BBIconLabel is a new class to display Icons without button. With a single method call it can be set up to convert entered text in InterfaceBuilder to Icons and scale them. No need to write code.
For a working demo see this project: git@github.com:katzlbt/iOSBootstrapButtonDemo.git
iOS7 compatible for those who do not like the new iOS7 design. 

#Adding BootstrapButton to your project

git submodule add git@github.com:katzlbt/iOSBootstrapButton.git BootstrapButton
XCode5 will ask you "Share working copy?" Answer: NO (not sure what this means though)

#Using BootstrapButton in your project

In InterfaceBuilder change the class-name of your Button from UIButton to BButton. That's it.
In InterfaceBuilder change the class-name of your Button from UIButton to BRadioButton. Then connect toNextRadioButton outlets in the storyboard in a circle (linked list) so the button may deselect others. Then set the selectedColor in the KV-coding list to blue or red and use the radio button. No code needed.
To programatically use the buttons (you don't need to do that at all) check out the demo XCode project git@github.com:katzlbt/iOSBootstrapButtonDemo.git

### Changes
* Added BRadioButton
* Removed unnecessary methods, cleanup
* Refactored to be able to use Icomoon Font or any other Font in Buttons.
* Switched from Arrays to memory friendier #define structure.
* Deprecated NSString extensions
* TODO: Draw icon separately of text as this thinns the label font from bold to regular (and loose the ability to display 2+ icons?)
* Addedd BBIconLabel class

#Original README BButton

Refactored by [@jessesquires](http://github.com/jessesquires), April 2013.

Includes [@leberwurstsaft / FontAwesome-for-iOS](https://github.com/leberwurstsaft/FontAwesome-for-iOS), fixed for iOS from the original [FontAwesome](http://fortawesome.github.com/Font-Awesome/).

![BButton Screenshot 1][img1] &nbsp;&nbsp;&nbsp;&nbsp; ![BButton Screenshot 2][img2]

### Notable changes

* Up-to-date for iOS 5.0+, ARC, Storyboards
* Custom initialization methods for easier creation
* Option to show button 'disabled' state
* New button type options
* FontAwesome already included
* Refactored to be much cleaner, better organized

### From source

* Drag the `BButton/` folder to your project (make sure you copy all files/folders)
* `#import "BButton.h"`
* Add `Fonts provided by application` key to `Info.plist` and include `FontAwesome.ttf`

<img src="http://imageshack.us/a/img339/9596/bbuttonfontawesomexcode.png">

## How To Use

### With Storyboards

Create a `UIButton` and change its class to `BButton`

<img width=261 src="http://img827.imageshack.us/img827/6596/ibbbutton.png"/>

Create a `UILabel` and change its class to `BBIconLabel` Then add a method to translate the text you set in IB as label text to icons.
[BBIconLabel setTextToIconMap:[NSDictionary dictionaryWithObjectsAndKeys: FAIconRemove, "#IL1", nil]];
 
### Create programmatically

**See the included demo project `BButtonDemo.xcodeproj`**

**See `FontAwesomeIcons.html` for list of icons**

## Apps Using This Control

[Hemoglobe](http://bit.ly/hemoglobeapp)

[iPaint uPaint](http://bit.ly/ipupappstr)

[Audiotrip](https://itunes.apple.com/us/app/audiotrip/id569634193?mt=8&ign-mpt=uo%3D4)

*[Contact me](mailto:me@mathieubolard.com) to have your app listed here.*

##[BButton](https://github.com/mattlawer/BButton) License

[MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2013 Mathieu Bolard and others

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

##[FontAwesome](https://github.com/FortAwesome/Font-Awesome) License

* The Font Awesome font is licensed under the [SIL Open Font License](http://scripts.sil.org/OFL)
* Font Awesome CSS, LESS, and SASS files are licensed under the [MIT License](http://opensource.org/licenses/mit-license.html)
* The Font Awesome pictograms are licensed under the [CC BY 3.0 License](http://creativecommons.org/licenses/by/3.0)
* Attribution is no longer required in Font Awesome 3.0, but much appreciated:
	* *"Font Awesome by Dave Gandy - http://fortawesome.github.com/Font-Awesome"*

[img1]:https://raw.github.com/mattlawer/BButton/master/Screenshots/screenshot-1.png
[img2]:https://raw.github.com/mattlawer/BButton/master/Screenshots/screenshot-2.png

##Contact (ORIGINAL AUTHOR)

mattlawer08@gmail.com<br />
http://mathieubolard.com<br />
http://twitter.com/mattlawer