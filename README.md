# LoL Yearbook

A social web app for League of Legends that allows users to write notes to players and comment on the champions they play.

View live site at [lol-yearbook.herokuapp.com](http://lol-yearbook.herokuapp.com).

Built with Ruby on Rails.

### Development:

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

### Contributing:

Create a new branch to work on features or changes:
```
$ git checkout -b your-new-featureg
```
Commit and push your work back up to your fork:
```
$ git push origin your-new-feature
```
[Submit a Pull request](https://help.github.com/articles/using-pull-requests/) so your changes can be reviewed.

!Be sure to merge the latest from "upstream" before making a pull request!
```
git remote add upstream https://github.com/sewardhorace/lol-yearbook.git
git pull upstream master
```

If you find a bug that you don't know how to fix, or you have an idea for a feature but you don't know how to implement it, please [create an issue](https://help.github.com/articles/creating-an-issue/)! (But first, check to see that someone didn't already create the same issue.)

### TODO:
- Crest for welcome page
- Icon for browser tab
- Allow replying to comments
- Testing??? I never learned how to write tests. It'd be great to have them.
- Allow users to edit their comments
- system/task for keeping riot api versions up to date
- better/more descriptive error handling/100% RESTful endpoints
- allow selection of region (probably should save region to book table)
- Procfile for Heroku (serve with Puma? Unicorn?)
- Optimizing database interactions (raw SQL)
- User page, favoriting summoners, some kind of feed
