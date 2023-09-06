using BookHundred.Data.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace BookHundred.Api.Controllers;

[Route("api/books")]
[ApiController]
public class BookController : ControllerBase
{
    private readonly IBookRepository _bookRepo;
    public BookController(IBookRepository bookRepo)
    {
        _bookRepo = bookRepo;
    }

    [HttpGet]
    public async Task<IActionResult> GetBooks(string? searchTerm, string? languages, string? sortColumn, string? sortDirection, int page = 1, int limit = 10)
    {
        try
        {
            var books = await _bookRepo.GetBooksAsync(page, limit, searchTerm, languages, sortColumn, sortDirection);
            return Ok(books);
        }
        catch (Exception ex)
        {
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
    }
}

