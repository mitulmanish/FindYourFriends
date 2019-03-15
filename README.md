# FindYourFriends
Task:
We have some customer records in a text file (customers.txt) -- one customer per line, JSON lines formatted. We want to invite any customer within 100km of venue for some food and drinks on us. Write a program that will read the full list of customers and output the names and user ids of matching customers (within 100km), sorted by User ID (ascending).

- The GPS coordinates for the venue are 53.339428, -6.257664.

Solution:

This App loads user locations from a text file and displays the list of people in close vicinity.

For example finding all the people with a 100 km radius results in:

|User ID|Name|
|---|---|
|4|Ian Kehoe|
|5|Nora Dempsey|
|6|Theresa Enright|
|8|Eoin Ahearn|
|11|Richard Finnegan|
|12|Christina McArdle|
|13|Olive Ahearn|
|15|Michael Ahearn|
|17|Patricia Cahill|
|23|Eoin Gallagher|
|24|Rose Enright|
|26|Stephen McArdle|
|29|Oliver Ahearn|
|30|Nick Enright|
|31|Alan Behan|
|39|Lisa Ahearn|

## Requirements
- Xcode 10.1*
- Swift 4.2

## Setup
- Clone the project
- Navigate to the project directory
- Open `DistanceCalculator.xcworkspace` using Xcode
- Run the App either on a simulator or an actual device

## Screenshots

### Data Loading

|Load Data|Show Guests|
|---|---|
|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/LoadCustomers.png?alt=media&token=a5b4dd73-020a-4905-82f5-8489e8919337)|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/ShowGuests.png?alt=media&token=46f9b3f5-4d1c-4246-a418-43a44c026b4c)|

### Error handling

|Problem Reading from file|No Guests Found|
|---|---|
|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/CantReadFileError.png?alt=media&token=aee017ba-3a5d-4880-a5ef-66d1f35fa02e)|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/NoGuestsFound.png?alt=media&token=14ada75f-7c9d-4308-8ffe-8b4649da0902)|

#### Results

|Guest List 1|Guest List 2|
|---|---|
|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/GuestList1.png?alt=media&token=695fa319-254a-49bc-b147-40065291bab3)|![Screenshot](https://firebasestorage.googleapis.com/v0/b/instafire-8f7b1.appspot.com/o/GuestList2.png?alt=media&token=ef76b49b-00b6-4421-b1e6-c61617d4dd31)|

