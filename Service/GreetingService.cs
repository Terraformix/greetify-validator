using GreetifyValidation.Data;

namespace GreetifyValidation.Service; 

public class GreetingService  {

    public bool IsValidGreetingForLanguage(string language, string greeting, bool? skipValidityCheck = false)
    {
        language = language.ToLower();
        greeting = greeting.ToLower();

        if (skipValidityCheck.HasValue && skipValidityCheck.Value) {
            return true;
        }

        var validGreeting = GreetingData.Greetings
            .FirstOrDefault(x => x.Key.Equals(language, StringComparison.OrdinalIgnoreCase)).Value;

        if (validGreeting == null)
        {
            return false;
        }

        return validGreeting.GreetingMessage.ToLower() == greeting;
    }
}