using System.Data;
using BookHundred.Data.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace BookHundred.Data.Repositories;

public class BookRepository : IBookRepository
{
    private readonly IConfiguration _config;
    private readonly string _connectionString;
    public BookRepository(IConfiguration config)
    {
        _config = config;
        _connectionString = _config.GetConnectionString("default");
    }

    public async Task<BookResult> GetBooksAsync(int page, int limit, string? searchTerm, string? languages, string? sortColumn, string? sortDirection)
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        using var multi = await connection.QueryMultipleAsync("spGetBooks", new { page, limit, languages, searchTerm, sortColumn, sortDirection }, commandType: CommandType.StoredProcedure);
        var books = await multi.ReadAsync<Book>();
        var paginationData = await multi.ReadFirstAsync<PaginationData>();
        return new BookResult { Books = books, PaginationData = paginationData };
    }

    public async Task<Book> GetBook(int id)
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        var books = await connection.QueryAsync<Book>("spGetBookById", new { id }, commandType: CommandType.StoredProcedure);
        return books.FirstOrDefault();
    }

    public async Task DeleteBook(int id)
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        var books = await connection.ExecuteAsync("spDeleteBook", new { id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<Book> AddBook(Book book)
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        var parameters = new DynamicParameters();
        parameters.Add("Id", 0, DbType.Int32, ParameterDirection.Output);
        parameters.Add("Title", book.Title);
        parameters.Add("Author", book.Author);
        parameters.Add("Country", book.Country);
        parameters.Add("Language", book.Language);
        parameters.Add("Link", book.Link);
        parameters.Add("ImageLink", book.ImageLink);
        parameters.Add("Price", book.Price);
        parameters.Add("Pages", book.Pages);
        parameters.Add("Year", book.Year);
        await connection.ExecuteAsync("spAddBook", param: parameters, commandType: CommandType.StoredProcedure);
        book.Id = parameters.Get<int>("Id");
        return book;
    }

    public async Task UpdateBook(Book book)
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        await connection.ExecuteAsync("spUpdateBook", book, commandType: CommandType.StoredProcedure);
    }

    public async Task<IEnumerable<string>> GetBookLanguages()
    {
        using IDbConnection connection = new SqlConnection(_connectionString);
        var languages = await connection.QueryAsync<string>("spGetLanguages", commandType: CommandType.StoredProcedure);
        return languages;
    }

}
