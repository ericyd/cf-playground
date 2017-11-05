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

## Code

This code doesn't use any sort of framework or anything like that, and I'm sure it's quite ugly by CF standards, but it's more of a project repo than anything so I don't really care.

Pull requests will not be considered, just fork it and do your own thing.




Also needs d3 and c3 installed for charts to work.