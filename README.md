# Video Games Database Model Documentation

## Overview
This document provides an overview of a relational database model designed to manage information related to game publishers, games, players, and their interactions. The database includes tables for publishers, games, genres, players, ownership, playtime, and reviews, along with supporting functions to extract and manipulate data effectively.

## Database Tables

### Publisher
Stores information about game publishers.
- **pub_name**: Name of the publisher (Primary Key)
- **headquarter**: Location of the publisher's headquarters
- **founded_date**: Date when the publisher was founded
- **employee_count**: Number of employees working for the publisher

### Game
Stores information about games.
- **game_name**: Name of the game (Primary Key)
- **pub_name**: Name of the publisher (Foreign Key referencing Publisher(pub_name))
- **description**: Description of the game
- **price**: Price of the game
- **release_date**: Release date of the game

### Genre
Stores information about game genres.
- **game_name**: Name of the game (Primary Key, Foreign Key referencing Game(game_name))
- **pub_name**: Name of the publisher (Primary Key, Foreign Key referencing Game(pub_name))
- **genre**: Genre of the game

### Player
Stores information about players.
- **id**: Unique identifier for the player (Primary Key)
- **name**: Name of the player
- **privacy_setting**: Privacy setting of the player

### Ownership
Stores information about game ownership by players.
- **id**: Unique identifier for the player (Primary Key, Foreign Key referencing Player(id))
- **game_name**: Name of the game (Primary Key, Foreign Key referencing Game(game_name))
- **pub_name**: Name of the publisher (Primary Key, Foreign Key referencing Game(pub_name))

### Playtime
Stores information about playtime for each game owned by players.
- **id**: Unique identifier for the player (Primary Key, Foreign Key referencing Player(id))
- **game_name**: Name of the game (Primary Key, Foreign Key referencing Game(game_name))
- **pub_name**: Name of the publisher (Primary Key, Foreign Key referencing Game(pub_name))
- **date**: Date of the play session
- **hours**: Hours played
- **minutes**: Minutes played

### Review
Stores information about reviews given by players.
- **game_name**: Name of the game (Primary Key, Foreign Key referencing Game(game_name))
- **pub_name**: Name of the publisher (Primary Key, Foreign Key referencing Game(pub_name))
- **id**: Unique identifier for the player (Primary Key, Foreign Key referencing Player(id))
- **recommendation**: Recommendation by the player ('yes' or 'no')
- **date**: Date of the review
- **comment**: Comment provided by the player
