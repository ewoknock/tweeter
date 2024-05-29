# Tweeter

A twitter clone build with Ruby on Rails. [Live Preview](https://tweeter-twitterclone.fly.dev/)
Feel free to test using:
username: tester@example.com
password: password

## About

Tweeter was created using The Odin Project's criteria for building a [Social Media Clone](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) as the starting point. This project also contains a testing suite that verifies what was or was not working during the development process.

## Technology used

- Ruby on Rails
- Hotwire - (Turbo and Stimilus)
- SCSS

## Features

- User Account
    - Devise gem for registering and logging user sessions
    - OAuth to sign up using Google

- Profile
    - Users have their own profile page where they can add and modify their location, url, bio, username, display name, and profile image (stored via active-record)

- Posts
    - Users can write posts and reply to other people's posts
    - Users can bookmark posts
    - Users can like posts

- Follow
    - Users can follow and un-follow other users
 
## Features to add
- Notifications
- Image posting
- Searching
- Hashtags
