Guile, The Gilt User Interface Librarye
=======================================

A collection of iOS components from the team at Gilt Mobile. This project is young; more details and functionality will be added soon.

## Components

- Status bar message area
- More coming soon!

## Demo App

A demo app project is embedded in the Guile framework project. It runs in the iOS simulator or on device.

## Using Guile

There are three primary methods of using Guile in your project

1. Download Guile.framework, then drag it into your XCode project
2. Clone guile and include it as a sub-project of your XCode project
3. Using Cocoapods (a sample Podfile is in GuileDemo)

I recommend option #1.

## Dependencies

A few Apple frameworks are needed to use Guile. They're probably already part of your project:

- Foundation
- UIKit
- QuartzCore

## Building the framework

To build Guile as a framework, you need to first install the IOS-Universal-Framework XCode templates. This can be done automatically by executing `./setup-xcode.sh`.

The `setup-xcode.sh` script will clone the IOS-Universal-Framework repository as a submodule, and execute it's installer.

## Follow Us

Check out the [Gilt Tech Blog](http://tech.gilt.com) to see what we're up to. Have questions? email us at mobile at gilt.com.

## License

Copyright 2013 Gilt Groupe, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
