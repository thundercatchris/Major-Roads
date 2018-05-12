# Major-Roads

TFL test


### Prerequisites

Cocpods need to be installed

A Device or iPhone simulator running iOS 10.3 or higher

Xcode 9.2 or higher

In order to use it you will need to register for a developer key here: https://api-portal.tfl.gov.uk/ 


### Installing

Clone the project. change to the installation directory in terminal and run "pod install".

Replace the hashed values with the credentials you obtained from the TFL portal

<img src=/images/screenShot1.png width="300" height="135">



### Testing

Some Unit tests have been included and can be run individually or as an entire class. 


### Built With

* [Alamofire](https://github.com/Alamofire/Alamofire) - The http request framework used
* CoreData - For favourite persistence 





# How to



## Search

Search for a major road from the search field to display its current status.

Favourite roads can also be added by pressing the 'Star' button next to a returned road and then viewed in the Favourites tab.

<img src=/images/IMG_1868.PNG width="300" height="650">




## Favourites

As the API allows for multiple roads to be requested at the same time, a Favourites view has been included.
The second tab displays any favourite roads you have added from previous searches. these can be selected for further information and removed from favourites if required.

<img src=/images/IMG_1869.PNG width="300" height="650">

