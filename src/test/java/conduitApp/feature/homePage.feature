Feature: Test for the homaPage

Background: Define URL
Given url baseURL

Scenario: Get all the tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['test', 'HuManIty']
    And match response.tags !contains 'Testing'
    And match response.tags contains any ['Apple', 'Ball', 'SIDA']
    # And match response.tags contains only []
    And match response.tags == "#array"
    And match each response.tags == "#string"

Scenario: Get all the articles
* def timeValidator = read('classpath:helpers/timeValidator.js')
    # Given param limit = 10
    # Given param offset = 0
    Given params { limit: 10, offset: 0 }
    Given path 'articles'
    When method Get 
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 500
    And match response.articlesCount != 100
    And match response == {"articles": "#array", "articlesCount":500}
    And match response.articles[0].createdAt contains '2020'
    And match response.articles[*].favoritesCount contains 1
    And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response.articles[*].favoritesCount == '#number'  
    And match each response..bio == '##string' 
    And match each response.articles ==
    """
        {
            "title": "#string",
            "slug": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "description": "#string",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            },
            "favorited": "#boolean",
            "favoritesCount": "#number"
        }
    """     


