namespace BookHundred.Data.Models;

public class BookResult
{
    public IEnumerable<Book> Books { get; set; }
    public PaginationData PaginationData { get; set; }
}

public record PaginationData(int TotalRecords, int TotalPages);