# Plenty of pics

<!--- These are examples. See https://shields.io for others or to customize this set of shields. You might want to include dependencies, project status and licence info here --->
![GitHub repo size](https://img.shields.io/github/repo-size/gu-tig169/grupp8)
![GitHub stars](https://img.shields.io/github/stars/gu-tig169/grupp8)
![GitHub issues](https://img.shields.io/github/issues/gu-tig169/grupp8)
![Github license](https://img.shields.io/github/license/gu-tig169/grupp8)

Plenty of pics is a flutter app that allows the user to view photos and search photos via the unsplash API.

This is a third year school project by six students studying at Gothenburg University in Sweden.

## Code structure
We have chosen not to break out all widgets in their own .dart files but instead only the more complex ones, such as the custom sliver appbar and loader indicators. Our reasoning for this decision is because we have a lot of small graphical widgets such as text fields and buttons that only are used in their own view. Each view is categorised into a separate folder where the index file describes the screen builder and separate components are stored in a components folder, if there are any.

<details>
  <summary>Illustrated code structure</summary>
  
  ![alt text](https://i.imgur.com/RB0nB9R.png ":)")
  
</details>

### Top level
    .
    ├── assets                  # external files that are used in the app
    ├── lib                     # source files
    └── README.md
    
#### /Assets
    .
    ├── ...
    ├── assets                  # external files that are used in the app
    │   ├── fonts               # font files
    │   ├── images              # image files
    └── ...
    
#### /Lib
    .
    ├── ...
    ├── lib                     # source files
    │   ├── models              # general constants, classes that are used more than once in our app
    │   ├── services            # API-service
    │   ├── views               # all different views that exsists in our app and their included components
    └── ...
    
## App screenshots
![Snapshots from our app](https://i.imgur.com/bkfZvgQ.png)

## Contributors

Thanks to the following people who have contributed to this project:

* [@AndreasAsen](https://github.com/AndreasAsen)
* [@carlengman](https://github.com/carlengman)
* [@ErikFrisenstam](https://github.com/ErikFrisenstam)
* [@evelinaBragsjo](https://github.com/evelinaBragsjo)
* [@EmilioSvensson](https://github.com/EmilioSvensson)
* [@imschafhauser](https://github.com/imschafhauser)


## License
<!--- If you're not sure which open license to use see https://choosealicense.com/--->

This project uses the following license: [GNU GPLv3](<https://choosealicense.com/licenses/gpl-3.0/#>).
