
# Meteo app
------------

Make a litte weather app with Open Weather Map api.

Setup project
-------

You need to add a weather api token in AppDelegate file: `let openweathermapToken = ""`.

If you want to connect the project with firebase account, add a GoogleService-Info.plist file in Meteo folder.

Todo
-------

[x] Get the route with default data for one location  
[x] Create model for this data  
[x] Use my app to codable a json   
[ ] Clean the classes  
[ ] Plug route about one location / détails  
[ ] Get a list of severals routes  

[ ] See if it easy to create a cell with a scroll view or a collectionView in each cells // Need to see the data for that  
[ ] Use kingfisher to cache images  
[ ] Get the current location and ask the location data to display like the first line, your location weather  
[ ] If I have the time made a screen with a UiAlert to ask if you want to share location informations  


[x] Add hero on project and manage a custom transition between this page and searchVC with just a blur on first page with a fade + little mouvement of title to transform the label in text field + a empty tableView for auto completion...  
[ ] If I have some time, I made a scroll and reduce the title/search textfield like the brainstormer...  
[ ] Bonus If you have time replace asset of weather with video or something like that to display in background the current state (maybe blurred) and details in front ...  


[ ] Add test for check if you have a specific behavior like when I click on add location, I have a default data mock or array and after I have the same kind of data + the new entry...  
[ ] Made a UI test scenario at the end with just  
[ ] Try jazzy ? I never implement on personal project ...  
[ ] Add localized if I have the time  
[ ] I need to save in local the list of location and maybe the last result for the current weather... and see if the date are now or not...  
[ ] Add a pull to refresh on differents tableView/collectionView  


