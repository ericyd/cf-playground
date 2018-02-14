# cf-playground
Just some code to get familiar with coldfusion, which is used extensively at my place of work.

It really isn't designed to be deployed, it's just for local development and experimentation.

## Setup

1. Download [Lucee express](http://download.lucee.org/?type=releases). 
At time of writing, 
[version 5.2.4.37](http://cdn.lucee.org/rest/update/provider/express/5.2.4.37) is the most recent.
2. Extract Lucee Express.
3. Navigate into the `webapps` folder. Assuming you just extraced version 5.2.4.37, this would look something like `cd lucee-express-5.2.4.37/webapps`
4. Rename the `ROOT` directory to something else like `ROOT-default`. Basically, we don't need these files so you can delete them if you want, but this way they just stay there and don't hurt anyone
5. Clone this repository into this directory and name it `ROOT`, e.g. `git clone https://github.com/ericyd/cf-playground ROOT`
6. Run `startup.sh` on linux or `startup.bat` on Windows. These are located in the root of the lucee-express directory
7. Navigate to [localhost:8888](http://localhost:8888) in your favorite web browser and you'll see the code!

As an example, if you download and extract Lucee to your downloads folder, you would want to run something similar to these commands (this is assuming linux because who even knows the windows commands for all this)

```
cd ~/downloads/lucee-express-5.2.4.37/webapps
mv ROOT ROOT-default
git clone https://github.com/ericyd/cf-playground ROOT
.././startup.sh
```

## Code

This code doesn't use any sort of framework or anything like that, and I'm sure it's quite ugly by CF standards, but it's more of a project repo than anything so I don't really care.

Pull requests will not be considered, just fork it and do your own thing.




Also needs d3 and c3 installed for charts to work.





## Testbox

### Installation

Looking into using [Commandbox](https://www.ortussolutions.com/products/commandbox) and [Testbox](https://testbox.ortusbooks.com/content/)

Once downloaded and extracted, make sure the executable is on your PATH

Install textbox: `box install testbox`



### Usage

Once you're in your directory, run `box` to start the CLI

Some useful commands

* Start local server: `start cfengine=adobe@11`
* Stop local server: `stop` (this is directory-specific)
* Run tests (must have local server running): `testbox run "http://localhost:8080/tests/runner.cfm"`


### Notes

* in order to access application scope from main app, you need to extend the main application.cfc from the application.cfc within testbox/tests and the call super.onRequestStart() or any other methods you need in that application.cfc
* to get to admin, go to <http://localhost:51879/CFIDE/administrator/index.cfm> and password is `commandbox`
* in `box.json`, the testbox default runner is set, so you can just run `testbox run` to run the tests
* add mapping to `/testbox` in application.cfc