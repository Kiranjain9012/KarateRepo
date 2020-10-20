Feature: To generate Token

    Scenario: To Generate token
        Given url baseURL
        Given path 'users/login'
        Given request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
        When method post
        Then status 200
        * def authToken = response.user.token
