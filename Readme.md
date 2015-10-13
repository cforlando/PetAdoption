## Build Instructions
This project utilizes Cocoapods. Please ensure you have <a href="https://guides.cocoapods.org/using/getting-started.html">CocoaPods installed</a>. Once installed, navigate to the project directory and run `pod install`. This will install all libraries necessary. Please do not import libraries directly but use CocoaPods where applicable. Once libraries are installed you can work on the project by opening the `.xcworkspace` file.

In order to build this project you will need keys for Parse.com. Parse will automatically create columns for you if you'd like to use your own keys, or you can use the Code for Orlando keys. Please contact akozlik at g mail.com for access to the keys. Keys should be stored in the root of the project under settings.xml and contain the dictionary keys parse_client_id and parse_application_id.

## Proto.io Mockup
https://codefortravel.proto.io/share/?id=f45f246b-3ea7-4587-a8aa-e9dbf0395593&v=3

## Pet Adoption iOS Requirements

This is the initial commit for a requirements document.

##### Purpose
[Code for Orlando](http://www.meetup.com/Code-For-Orlando/) is a [Code for America](https://www.codeforamerica.org/) brigade.

The goal of this app is to make it as easy as possible to allow potential pet rescuers to find and adopt pets.

##### App Functions


* List of all animals available for adoption including breed, photos, name if available, date brought to shelter, etc.

* Ability to set an alert to email or send a push notification when a specific breed is available.

* Ability to contact shelter with questions.

* Ability to fill out adoption application online for pre-screening.

* Interact with social media if available.


#### Possible data model to include:
* Shelter:
  * name
  * address
  * list of conversations had with this location?
  * all pets available
* Pet
  * name
  * Id number
  * Species (dog, cat, etc)
  * breed
  * (approximate) Age
  * Size (small, large, etc)
  * Gender
  * Color
  * Spayed/Neutered
  * House trained
  * Declawed
  * photos
  * date of arrival
  * Shelter (inverse relationship)
  * Adoption fee (if any)
  * description (special needs, etc)
* User
  * name and other info as needed
  * if user is pre-approved/screened or not for adoption?


#### Possible design elements

An application with the following tabs, each using a navigation controller:
* Pets
* Shelters
* User
* About

##### Pet Tab
The pet tab might allow for searching based on various parameters, such as breed, size, etc.  It might also allow searches by distance and dates pets arrived at shelters (newest/oldest).

A table view may show the pets listed in order, along with a photo and other important info.  Tapping a cell will go to the pet page.

The pet page will have various data described in the model above, as well as social sharing options.  It should also have a way to inform the shelter of the user's desire to adopt the pet.

##### Shelter Tab
Shelters may be searchable as pets are, based on basic inputs, such as user location and distance.  The result might be listed in a table view.  When a user taps a cell, it should navigate to a details page.

The details page allows users to contact the shelter (pre-filled out email?), 

##### User Tab
This tab allows the user to fill out basic info (if desired).  This makes it easier to start email conversations with shelters as well as fill out pre-screening info.  It should also contain a button to a map view, or embed a map view.

##### About Tab
This is important as it will allow other cities/counties learn more about how to access the code and make it usable for their locations.

#### Potential Problems and questions that need clarification
* Does each county or shelter require different pre-screening?
* How will we handle different API's between each version of the app?  Is it unreasonable to expect various locations to make their own version?
* Anything else?

#### TODO:
* Develop a set of documents that show how to fork and add different locations to the codebase, in separate apps.
