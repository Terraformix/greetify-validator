using GreetifyValidation.DTO;
using GreetifyValidation.Service;
using Microsoft.AspNetCore.Mvc;

namespace GreetifyValidation.Controllers; 

[Route("api/greetings")]
[ApiController]
public class GreetingValidatorController : ControllerBase {
    
    private readonly GreetingService _greetingService;

    public GreetingValidatorController(GreetingService greetingService)
    {
        _greetingService = greetingService;
    }

    
    [HttpPost("validate")]
    public async Task<IActionResult> Validate([FromBody] GreetingRequest request, bool? skipValidityCheck = false)
    {
        bool isValid = _greetingService.IsValidGreetingForLanguage(request.Language, request.Greeting, skipValidityCheck);
        
        if (isValid)
        {
            return Ok("The greeting is valid.");
        }
        else
        {
            return BadRequest("The greeting is invalid for the specified language.");
        }
    }
}