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

}
