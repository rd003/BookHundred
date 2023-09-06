using BookHundred.Data.Models;

namespace BookHundred.Data.Repositories;

public interface IBookRepository
{
    Task<BookResult> GetBooksAsync(int page, int limit, string? searchTerm, string? languages, string? sortColumn, string? sortDirection);
}