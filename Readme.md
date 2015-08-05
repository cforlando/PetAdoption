## Pet Adoption iOS Requirements

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
  * RFID Tag number (microchip)
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

~~A table view may show the pets listed in order, along with a photo and other important info.  Tapping a cell will go to the pet page.~~
Meetup on Aug 4th came up with a good idea for a PinInterest or Instagram style feed, showing most recent pets.  Possibly with a search bar and extra search paramerters button (leading to a categorical search, similar to eBay).

The feed might also have filters to only show certain types of posts (dogs, cats, etc).

The pet page will have various data described in the model above, as well as social sharing options.  It should also have a way to inform the shelter of the user's desire to adopt the pet.

##### Shelter Tab
Shelters may be searchable as pets are, based on basic inputs, such as user location and distance.  The result might be listed in a table view.  When a user taps a cell, it should navigate to a details page.

Some rescue shelters don't want to list an address, but will have some identifiable location, such as a P.O. Box.

The details page allows users to contact the shelter (pre-filled out email?), 

##### Lost Pet Tab

This might allow a user to report a recently lost pet.  It could allow for entry of information such as name, breed, color(s), microchip number, upload a photo, etc.

##### User Tab
This tab allows the user to fill out basic info (if desired).  This makes it easier to start email conversations with shelters as well as fill out pre-screening info.  It should also contain a button to a map view, or embed a map view.

Note that in order to comply with PII rules (Personally Identifiable Information), a disclaimer is needed that their name, email, etc, will become a matter of public record.

##### About Tab
~~This will allow other cities/counties learn more about how to access the code and make it usable for their locations.~~
This tab will likely be removed as it's not really needed.

#### Additional Notes

Breeds are usually standard, but often have incorrect terminology and slang, as well as mixes of breeds.  When giving users the option of what breed to pick, we should also suggest related breeds as well.

Age might also be entered in an age range, as opposed to specific ages.  Maybe this is an optional choice?

We might consider localization, at least for Spanish.

Sheltermanager.com is an open source tool for tracking shelters and may be useful.

#### Potential Problems and questions that need clarification
* Does each county or shelter require different pre-screening?
* ~~How will we handle different API's between each version of the app?  Is it unreasonable to expect various locations to make their own version?~~
  * This was discussed at the meetup, the tenative plan is to build an interface API on the backend that connect to other API's such as adopt-a-pet, instagram, etc.
* Anything else?

#### TODO:
* Develop a set of documents that show how to fork and add different locations to the codebase, in separate apps.
* 
