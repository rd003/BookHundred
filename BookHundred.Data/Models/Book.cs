namespace BookHundred.Data.Models;

public class Book
{
    public int Id { get; set; }
    public string? Author { get; set; }
    public string? Country { get; set; }
    public string? ImageLink { get; set; }
    public string? Language { get; set; }
    public string? Link { get; set; }
    public int Pages { get; set; }
    public string? Title { get; set; }
    public int Year { get; set; }
    public double Price { get; set; }
}
