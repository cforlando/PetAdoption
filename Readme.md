this is a test
# Pet Adoption for iOS[![Build Status](https://travis-ci.org/cforlando/PetAdoption-iOS.svg?branch=master)](https://travis-ci.org/cforlando/PetAdoption-iOS)
-----
## About
------
**Pet Adoption** is an iOS app being built for the Town of Lady Lake, Florida to assist citizens in adopting animals for local shelters.

**Version** 1.0 (MVP)

**Feature List** A list of features we would like finished for version 1.0 can be found [here](MVP_PRODUCT_LIST.md).

**Prototype** https://codefortravel.proto.io/share/?id=f45f246b-3ea7-4587-a8aa-e9dbf0395593&v=3

**Other Repositories**
- Pet Adoption for Android: https://github.com/cforlando/PetAdoption-Android
- Pet Adoption for WordPress: https://github.com/cforlando/PetAdoption-WordPress

**Project Lead**

John Li (johnliglobal@gmail.com) (slack: johnleeroy)

## Requirements
------
- Xcode v9.0
- Cocoapods v1.3.1

If you do not have CocoaPods installed, you can do so by opening Terminal and entering: `sudo gem install cocoapods`.  Once you have done that, navigate to the project directory and run `pod install`.  Make sure you open the .xcworkspace for the project.

### IMPORTANT NOTE TO CONTRIBUTORS
v1.0 of the Pet Adoption app uses the PetFinder API. As such, an API key is required.  This project does not include an API key by default, so you **will** need to get one.  You can get a free developers API key for PetFinder at https://www.petfinder.com/developers/api-key.  You will need to create a free account in order to get an API key.

Once you have your API key, you will need to create an `apikey.plist` file.  For your convenience, there is a file called `apikey.plist.example` provided.  Simply create a copy of this file, rename it to `apikey.plist`, open it, and enter your API key into the appropriate place.  `apikey.plist` is include in the `.gitignore` file, so you don't need to worry about removing this file before submitting pull requests but please make sure that you don't remove the `apikey.plist.example` file in your PRs.

## Want to contribute?
------
If you'd like to contribute, check out our [Contributing](CONTRIBUTING.md) page for more details.

## License
------
[The MIT License (MIT)](LICENSE.md)

## About Code for Orlando
------
[Code for Orlando](http://www.codefororlando.com/), a local Code for America brigade, brings the community together to improve Orlando through technology.  We are a group of "civic hackers" from various disciplines who are committed to volunteering our talents to make a difference in the local communmity through technology.  We unite to improve the way the community, visitors, and local government experience Orlando.
