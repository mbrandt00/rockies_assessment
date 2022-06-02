# README

This is a basic pitch tracking app to assess pitch counts, strike percentages, release speed etc of various pitchers on the Colorado Rockies. 

## Run Instructions 
This should take no longer to get a fully functional app with 10% of the data loaded in. To get 100% of the data, I estimate ~30 minutes. 
 - Clone down the repository 
 - Ensure that docker is running locally
 - Run `docker-compose run web bash`
 - In bash run `rails db:{create,migrate} pitches` (**this step will take a long time.** The console output will print out what percent of the CSV has been parsed in. Feel free to terminate early.)
 - Exit the bash session
 - Run `docker-compose up`
 - In your browser, navigate to `http://localhost:3000/averages`

## Work summary 
I am proud of the work done on parts (1) and (2)

- Part (1) consisted of building up an overview page that presents averages for each pitcher by pitch-type. Included are averages on Release Speed (coming from the pitch_release_speed column of excel) and release extension (from pitch_release_extension) as well as percentages on balls, strikes, and in play pitches. There are also options for searching for a pitcher by (partial/case insensitive) name and filtering by pitch-type via radio buttons. See `/models/pitcher.rb` for these active record queries. 

- Part (2) is essentially the show page from the index of part(1). To the extent of the data, all five pitch type averages for a certain pitcher will be present in teh show page, as well as pitch outcomes. Pitch outcomes presented a particularly challenging aspect of this project, since each row in the Excel file consists of a pitch, and not an at bat. To get this information a combination of active record and ruby enumerables were used. See `models/game.rb #event_description_count(pitcher)` for the code. 

- Part (3) presented a challenge. At this point, I had dockerized the application (a new technology for me). I quickly realized that a lot of the dependencies that I use are not well optimized for an M1 mac, and fundamental tools that I would use to develop active record queries like the rails console were unavailable for me. That being said, I prioritized Docker over part (3), but some of the initial work for team summary statistics can still be viewed in `models/team.rb`

In addition, model level tests and feature tests were written to appropriate behavior. Open up the bash console for the container by running 
`docker-compose run web bash`
and run the tests 
`bundle exec rspec`

## Possible extension work 

I would really have liked to fill in Part (3) with more detailed information on pitch outcomes. I imagine something similar to the game level data for pitch outcomes present in part (2). The nature of the data makes it challenging, since I would be starting with an instance of team, and needing to group by bother pitcher and at-bats and counting pitch-outcomes.

I initially considered trying to implement more standard pitcher metrics, chiefly ERA. This desire was curtailed by the data, since no information is present on what happens after a batter gets on base (ie whether the batter "made it home"). 

Also, due to the nature of this project, I didn't feel it necessary to hide secrets in environment variables for the docker database. In a production level app where it is necessary to take those precautions, I certainly would have designed that part of the application differently. 