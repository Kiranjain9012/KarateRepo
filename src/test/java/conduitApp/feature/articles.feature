@parallel=false
Feature: Articles

Background: PreConditions
    * url baseURL
    * def addArticleRequestBody = read('classpath:conduitApp/json/addArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set addArticleRequestBody.article.title = dataGenerator.getRandomArticleValues().title;
    * set addArticleRequestBody.article.description = dataGenerator.getRandomArticleValues().description;
    * set addArticleRequestBody.article.body = dataGenerator.getRandomArticleValues().body;
    * call read('classpath:helpers/common.feature')
    # * def tokenResponse = callonce read('classpath:helpers/generateToken.feature')
    # * def token = tokenResponse.authToken
@Test1
Scenario: Add Articles
    # Given header Authorization = 'Token '+ token
    Given path 'articles'
    Given request addArticleRequestBody
    When method post
    Then status 200
    And match response.article.title == addArticleRequestBody.article.title
    * def slug = response.article.slug
    * writeToFileWithName(slug,'slugID')

Scenario: Add and Delete Article
    # Given header Authorization = 'Token '+ token
    Given path 'articles'
    Given request addArticleRequestBody
    When method post
    Then status 200
    And match response.article.title == addArticleRequestBody.article.title
    * def slug = response.article.slug

     #Get Articles
    Given params { limit:10, offset:0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == addArticleRequestBody.article.title

    #Delete API 
    # Given header Authorization = 'Token '+ token
    Given path 'articles',slug 
    When method Delete
    Then status 200

    #Get Articles
    Given params { limit:10, offset:0 }
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != addArticleRequestBody.article.title
