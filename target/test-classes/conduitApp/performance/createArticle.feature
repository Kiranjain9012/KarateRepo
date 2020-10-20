
Feature: Articles

Background: PreConditions
    Given url baseURL
    * def addArticleRequestBody = read('classpath:conduitApp/json/addArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set addArticleRequestBody.article.title = __gatling.Title
    * set addArticleRequestBody.article.description = __gatling.Description
    * set addArticleRequestBody.article.body = dataGenerator.getRandomArticleValues().body;
    # * def tokenResponse = callonce read('classpath:helpers/generateToken.feature')
    # * def token = tokenResponse.authToken
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)      

Scenario: Add and Delete Article
    # Given header Authorization = 'Token '+ token

    Given path 'articles'
    Given request addArticleRequestBody
    And header karate-name = "Create Article"
    When method post
    Then status 200
    And match response.article.title == addArticleRequestBody.article.title
    * def slug = response.article.slug

    # * pause(5000)

    # #Delete API 
    # # Given header Authorization = 'Token '+ token
    # Given path 'articles',slug 
    # When method Delete
    # Then status 200
