# my_movie_api
Creating a backend api using rails for searching and wishlisting movies.

Features:
* Authentication using devise - email confirmation, password reset flow, etc
* Search using pg-search gem
* Lists - User can create, update, delete lists
* User can add delete movies in a list
* Search history


Following APIs are created:

GET api/v1/search/ → search a movie by name and other filters(take reference from CLI project) like year, genre etc

GET api/v1/search/autocomplete → search autocomplete API

GET api/v1/search/history → get user’s search history, the items users clicked on search suggestions

GET api/v1/mylists/all → Get a list of all my lists

POST api/v1/mylists → create a new list

GET api/v1/mylists/<list-id> → get details of a specific list (name, created date, etc)

PUT api/v1/mylists/<list-id> → update list details

GET api/v1/movies/?list_name=<list_name>  → get a list of all the movies in a list


  
  The basic contract of all APIs can look like this:


// success
{
  "data": [{},{},{}],
  "success": true,
  "meta_data": {
    
  }
}

// error:
{
  "error": {
    "status_code": 404,
    "message": "ID not found",
    "details": ""
  },
  "success": false,
  "meta_data"
}
