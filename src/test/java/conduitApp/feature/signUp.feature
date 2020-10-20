Feature: New user sign up service

Background: PreConditions
    Given url baseURL
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * def randomEmail = dataGenerator.getRandomEmail();
    * def randomUsername = dataGenerator.getRandomUserName();
 
Scenario: Positive : Sign up a new user
    # Given def userData = {"email":"User120@test.com","username":"User120"}
        Given path 'users'
    # And request {"user":{"email":#(userData.email),"password":"user12345","username":#(userData.username)}}
    And request
    """
        {
    "user": {
        "email": #(randomEmail),
        "password": "user123454",
        "username": #(randomUsername)
    }
}
    """
    When method Post
    Then status 200
    And match response ==
    """
{
    "user": {
        "id": "#number",
        "email": #(randomEmail),
        "createdAt":  "#? timeValidator(_)",
        "updatedAt":  "#? timeValidator(_)",
        "username": #(randomUsername),
        "bio": null,
        "image": null,  
        "token": "#string"
    }
}
    """
    @Test    
    Scenario Outline: Negative : Sign up a new user to check error messages
    # Given def userData = {"email":"User120@test.com","username":"User120"}

    Given path 'users'
    # And request {"user":{"email":#(userData.email),"password":"user12345","username":#(userData.username)}}
    And request
    """
        {
    "user": {
        "email": "<email>",
        "password": "<password>",
        "username": "<username>"
    }
}
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

        Examples: 
        | email               | password   | username          | errorResponse                                      |
        | Karate9012@test.com | user123454 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}    |
        | #(randomEmail)      | user123454 |  User12091        | {"errors":{"username":["has already been taken"]}} |