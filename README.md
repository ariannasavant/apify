apify
=====

Apify helps turn Rails routes into a resource-nested JSON object that can be easily accessed and parsed by a front-end client.
Please note that Apify is meant to be used with Rails, and is not supported for other Ruby frameworks.

To Use:
-------

1.  **Install:** Add the gem to your Gemfile:  `gem 'json_routes'`
2.  **Mount Routes:** Decide the base of the URL at which you want to access the JSON routes object, and mount json_rails's Engine there.  In `/config/routes.rb` add the following: 
  
        mount JsonRoutes::Engine, at '/<base-name-of-your-choice>'  

 You might, for example, choose to mount at `/apify`, which would make the JSON routes object available at `/apify`.  You can play around with how you want this to look by mounting, and then seeing the result with `rake routes`.

3.  **Run rake task:** Then run `rake json_routes` to initialize your JSON routes file.  **You will need to run this before every deployment (production mode), or with every change to `/config/routes.rb` (development mode).** 
  TODO: use Listen gem in development mode, to run this task automatically when the `routes.rb` file is updated.  

4.  **Done!** You're set up!  Navigate to `/<your base name>` to get the route JSON back.  
Clients can save this locally, and use the `:name` of the route as a helper method in their code, rather than hard-coding the URL strings.  Clients can reference `/<your base name>/info` to see when the file was last updated.  It is our suggestion to save the JSON tree and this timestamp locally on the client, checking for updates to the JSON tree whenever a user logs in.

Coming Soon:
------------

1.  Angular client library to parse the JSON tree and create a Javascript object, stored locally, that would enable you to do something like this:

                $http
                    .post(API.routes.comments_url, {id: 1, content: "awesome!"})
                    .success(function(data, status, headers, config){
                         // yada yada
                });

2.  implementation of Listen gem, so you don't have to run the rake task in development with every new/updated route
3.  TESTS! :)
