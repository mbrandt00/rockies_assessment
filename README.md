# README

This is a basic pitch tracking app to assess pitch counts, strike percentages, release speed etc of various pitchers on the Colorado Rockies. 

## Run Instructions 
 - Clone down the repository 
 - Run `docker build .`
 - Run `docker-compose run web bash`
 - In bash run `rails db:{create,migrate} pitches` (this step will take a long time. The console output will print out what percent of the CSV has been parsed in. Feel free to temrinate early.)
 - Run `docker-compose up`
 - In your browser, navigate to `http://localhost:3000/averages`

 ## Assumptions

 