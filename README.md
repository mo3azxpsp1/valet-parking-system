# Valet Parking System

## Rquirements
`Ruby` and `Rails`
 You should have ruby and rails installed on your machine to be able to run the app.

## Dependencies
- Ruby 2.5.1
- Rails 5.2.3
- Sqlite3 1.4.1

## Steps
- Clone the repo
- When you are in the root of the app, run `bundle i` to install the dependencies.
- Run `rails db:create db:seed` to create the database and seed the primary data into it.
- Run `rails s` to run the local server
- You can access the app on `http://localhost:3000`

## User Stories
- Admin can find a list of bays in the home page.
- Admin can create, edit, delete any bay.
- Admin can click on 'Park Car' to fill the details of the car he wants to park in specific bay.
- Admin can click on the no of the parking car for each bay to be redirected to a list of the cars.
- From this list, admin can collect or move any car.
- Admin can find a receipt generated on the screen after collecting a car from any bay.
- Admin cannot collect a blocked car in the double sized bays until moving the blocking car to another bay.
- Admin can track all parking cars in the valet ordered by the parking time descendingly on clicking on 'Track all Parking Cars' button.