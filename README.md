# iTunesSearch
## Task
In the test task, need to develop a simple application for the iPhone. The application should display album artwork from the iTunes API, and the user should be able to see detailed information about the selected album.
Also, search history needs to be saved and user can see the search history on the second tab, after tapping on the search string search result should be opened.

#### UI Description:

- UITabBarController with two tabs (Search, History)
- Tab with UISearchBar for start and stop searching
- UICollectionView with albums
- after selecting an album, you need to display a screen with full information about the album and list of songs (in both tabs - Search and History)
- Tab with search history
- UITableView with history from UISearchBar input text. This history should be saved between application launch
- after selecting search string, you need to display a screen with search result

#### Other requirements:

- must use the latest Xcode 11+, Swift 5+, iOS 12+, don't use SwiftUI
- navigation between screens
- albums have to be sorted alphabetically
- API description: https://affiliate.itunes.apple.com/resources/documentation/itunes-store- web-service-search-api/


## Technologies used

- UIKit
- SnapKit
- Swift Package Manager
- URLSession, JSONDecoder
- AutoLayout
- Without Storyboard
