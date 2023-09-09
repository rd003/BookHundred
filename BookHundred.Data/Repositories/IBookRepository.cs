using BookHundred.Data.Models;

namespace BookHundred.Data.Repositories
{
    public interface IBookRepository
    {
        Task<Book> AddBook(Book book);
        Task DeleteBook(int id);
        Task<Book> GetBook(int id);
        Task<BookResult> GetBooksAsync(int page, int limit, string? searchTerm, string? languages, string? sortColumn, string? sortDirection);
        Task UpdateBook(Book book);
    }
}