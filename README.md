Guile, The Gilt User Interface Librarye
=======================================

A collection of iOS components from the team at Gilt Mobile. This project is young; more details and functionality will be added soon.

## iOS Components

### Status bar message area!


### Autocompleting Text Field!
Built on top of UITextField, with support for arbitrary suggestions.

![image](http://adkap.com/guile-images/autosuggest.gif)
### More coming soon!
The project is an ongoing effort.

## Demo App

A demo app project is embedded in the Guile framework project. It runs in the iOS simulator or on device.

## Using Guile

There are three primary methods of using Guile in your project

1. Download Guile.framework, then drag it into your Xcode project
2. Clone guile and include it as a sub-project of your Xcode project
3. Using CocoaPods (a sample Podfile is in GuileDemo)

I recommend option #1.

## Dependencies

A few Apple frameworks are needed to use Guile. They're probably already part of your project:

- Foundation
- UIKit
- QuartzCore

## Building The Framework

### Combined iOS Device / Simulator Framework

To build Guile as a universal framework, you must ensure that the aggregate "Framework" build scheme is selected. Then simply use Command+B. To find the resulting Guile.framework: in the project navigator, right-click on libGuile.a under Products and select "Show In Finder".

### Seperate iOS Device / Simulator Frameworks

You might want to reduce the size of the distributed library by only including minimum architectures for an iOS device. In this case, you'll need to build Guile twice: once targetting a simulator and again tagetting iOS Device. When building for iOS Device, open the project's Build Settings for Guile (the library) and set **Build Active Architecture Only** to true. Add both framework version to your app's project, then link one debug and another to your distribution target. (Honestly this is overkill; most folks would be better off compiling Guile in as a submodule)

## Follow Us

Check out the [Gilt Tech Blog](http://tech.gilt.com) to see what we're up to. Have questions? email us at mobile at gilt.com.

## License

Copyright 2014 Gilt Groupe, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
