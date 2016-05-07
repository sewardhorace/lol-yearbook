# LoL Yearbook

A social web app for League of Legends that allows users to write notes to players and comment on the champions they play.

View live site at [lol-yearbook.herokuapp.com](lol-yearbook.herokuapp.com).

Built with Ruby on Rails.

### Contributing:

Make sure you have Ruby and Ruby on Rails installed. Since I depoy with Heroku I use PostgreSQL, so you'll need to have that installed as well. Fork this repository, then clone it to your machine:
```
$ git clone https://github.com/YourUsername/lol-yearbook.git

```

If you don't have bundler, you must first install it
```
$ gem install bundler
```

Navigate to the directory you just created and run
```
$ bundle install
```

Lol Yearbook accesses the Riot API and authenticates users through Twitter. You will need API keys from Riot and Twitter, which can be obtained by registering at https://developer.riotgames.com/ and https://apps.twitter.com/, respectively. To keep these keys secret in the app, we must provide them as ENV variables. I use the figaro gem.

Run 
```
$ bundle exec figaro install
```
And place the following in the generated application.yml file
```
# config/application.yml

RIOT_KEY: "YourRiotKey"
TWITTER_KEY: "YourTwitterKey"
TWITTER_SECRET: "YourTwitterSecret"
```

Next, set up the database by running
```
rake db:create db:migrate update_static_data
```

Now run
```
$ rails s
```
to start the server. Open a browser and navigate to localhost:3000.

TODO:
Testing???
UI
- icon for browser tab
- crest for welcome page
- better way to do bg images?
allow editing comments?
replying to comments (will have to modify delete method)
upvoting/downvoting comments
system/task for keeping riot api versions up to date
limit how often a profile can be updated (24 hours?)
model validation
better/more descriptive error handling
allow selection of region (probably should save region to book?)
add champion quotes



