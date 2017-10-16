# Flickr-Image-Gallery
Application to display an image gallery of the Flickr Public Feed.

### How to get started
Just download the project and Cmd+R (Run)

### Architecture
The following application was implemented using the MVVM architecture pattern. 
- The chosen architecture enables developers to separe 'view' and 'model’, making possible for changes happen only on model with those changes not being reflected on view's implementation.

### Project Overview

* `FlickrService.swift` - Handles the Requests to Flickrs's API.
* `ModelFlickrPhoto.swift` - Data model with the information we want to show in the app.
* `FeedViewModel.swift` - Load and format feed information to be displayed in the views.
* `Flickr Image GalleryTests` - Folder with unit tests.

### Requirements 
The current version requires:
- Xcode 9 or later
- Swift 4.0 or later
- iOS 9 or later


### Author
- [Enrique Melgarejo](https://www.linkedin.com/in/enriquecm/)
