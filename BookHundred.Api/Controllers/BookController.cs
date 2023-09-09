using BookHundred.Data.Models;
using BookHundred.Data.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace BookHundred.Api.Controllers;

[Route("api/books")]
[ApiController]
public class BookController : ControllerBase
{
    private readonly IBookRepository _bookRepo;
    private readonly ILogger<BookController> _logger;
    public BookController(IBookRepository bookRepo,ILogger<BookController> logger)
    {
        _bookRepo = bookRepo;
        _logger = logger;
    }

    [HttpPost]
    public async Task<IActionResult> AddBook(Book book)
    {
        try
        {
            await _bookRepo.AddBook(book);
            _logger.LogInformation("added successfully");
            return CreatedAtAction(nameof(AddBook), book);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
    }

    [HttpPut]
    public async Task<IActionResult> UpdateBook(Book book)
    {
        try
        {
            var bookToUpdate = await _bookRepo.GetBook(book.Id);
            if (bookToUpdate == null)
            {
                return NotFound(new StatusModel
                {
                    StatusCode = 404,
                    Message = $"Book with id {book.Id} does not exists."
                }) ;
            }


            await _bookRepo.UpdateBook(book);
            return Ok(new StatusModel
            {
                StatusCode = 200,
                Message = "Updated successfully"
            }); 
        }
        catch (Exception ex)
        {

            _logger.LogError(ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
    }


    [HttpGet("{id}")]
    public async Task<IActionResult> GetBook(int id)
    {
        try
        {
            var book = await _bookRepo.GetBook(id);          
            if (book == null)
            {
                return NotFound(new StatusModel
                {
                    StatusCode = 404,
                    Message = $"Book with id {id} does not exists."
                });
            }
            return Ok(book);
        }
        catch (Exception ex)
        {

            _logger.LogError(ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteBook(int id)
    {
        try
        {
            var book = await _bookRepo.GetBook(id);
            if (book == null)
            {
                return NotFound(new StatusModel
                {
                    StatusCode = 404,
                    Message = $"Book with id {id} does not exists."
                });
            }
            await _bookRepo.DeleteBook(id);
            return Ok(new StatusModel
            {
                StatusCode = 200,
                Message = "Deleted successfully"
            });
        }
        catch (Exception ex)
        {

            _logger.LogError(ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
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
            _logger.LogError(ex.Message);
            return StatusCode(StatusCodes.Status500InternalServerError, new StatusModel
            {
                StatusCode = 500,
                Message = "Oops! something went wrong"
            });
        }
    }
}

