# BookHundred

This application contains webapi crud operations built with .net core 7 web api, dapper and sql server. It is well designed backed with searching, sorting and pagination.
I am also using **non clustered index** on title,author and language.

## Requirements
* .net core 7 or higher (If you are watching in future)
* sql server 2016 (min), otherwise you have write split string mangully.
* 
## How to use it.
 * Clone the project and adjust connection string in `appsettings.json` according to your sql server.
 * Copy the db script from `db_script.sql` and run it in your sql server management studio. It will create database and enter 100+ data in `dbo.book` table

## Endpoints
   * api/books (post)
   * api/books (put)
   * api/books (get) (option params)
   * api/books/{id} (get)
   * api/books/{id} (delete)
