# rails_lite

This is a lite version of the popular ruby framework "Rails"


##Installation

* Download the repo
* Navigate to the directory in your terminal
* In the terminal run bundle exec bundle install
* Navigate to the 'bin' folder and run 'ruby basic_server.rb'
* In the browser, go to localhost:3000

##Features

###Router
The router is instantiated in basic_server.rb

Each time we create a new router object, we also define a set of route paths to go with it.
These route paths are created using the 'create_method' method. Their source code can be found at
lib/route.rb

###Render Template

In order to render templates successfully, we need to have a controllerbase.render method.

This render method needs to do a few things: 
* Read the file where the .erb template lives
* render it using erb
* write the content to the respoonse



