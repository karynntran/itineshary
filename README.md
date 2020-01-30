# itineshary

## Overview
Itineshary an iOS app that allows users to search for a destination and create itineraries by sharing recommendations.

## Stack
*Language*: Swift, Xcode and SQLite3

*APIs Used:* https://rapidapi.com/natkapral/api/countries-cities 


## Features 
_Tabbed Item navigation, allowing users to toggle through a Places section, a Recommendations section, an All Recommendations section and a City View section_
	
**Places**

Users typically start here. This view includes two UIPickers for selecting a country and a city. Upon loading, an API request is made and loads in all the countries. Once a user selects a country, the API is called again to request the cities associated with that country. Once a valid city has been selected, an Add Recommendation option on the tab bar is enabled. If not, the Add Recommendation option remains disabled.

**Recommendations**

The SQLite Database is connected in this view controller to store all the inputs.
		Users can input their recommendation, additional notes, and check off one or more features that apply to recommendation (i.e. it's an activity, lunch recommendation, drinks recommendation). If all fields are valid, users are able to submit. This input is saved into the SQLite3 database.

Additionally, at this stage, users can click on a button to see all the recommendations associated with this city. More on under City View section.

**All Itineraries**


This is a table view that lists all cities that have itineraries. The array of data has been transformed into a Set so that each cell is unique, whether multiple inputs for a country and city have been made or not. Once a user clicked on a cell, they are taken to a list of all that city's recommendations.

If no recommendations have been added yet, users will only see a cell that says "No recommendations added yet."

**City View**


A user can access a city's recommendations through the Recommendations tab or after clicking through the All Itineraries tab. This is laid out as a collection view, which renders a styled list of all the recommendations that have been added for the city. 