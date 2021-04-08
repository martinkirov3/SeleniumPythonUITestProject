
@tag
Feature: API test with Karate DSL GET POST

  @tag1
  Scenario: Verify return of user not found / No Server Response status 404+
  
    Given  url apiURL + 'user'
	And request { id: '1234' }
    When method get
    Then print responseStatus
    And assert responseStatus >= 404
  
    
  @tag2
  Scenario: Verify return of pre-defined user status 200  

    Given  url apiURL + 'user'
	And request { id: 'pepe@pepe.pe1-0.2' }
    When method get
    Then status 200
    And match $ contains {"name":"pepe", id: 'pepe@pepe.pe1-0.2',bookings:[],email:'pepe@pepe.pe1-0.2'}
    
        
  @tag3
  Scenario: Create User POST
	
	Given url apiURL + 'user'
	And request { email: 'test2@test.com' , name: 'Test User 2'}
    When method post
    Then status 201
    And match $ contains {name: 'Test User 2', id: '#notnull',bookings:[],email:'test2@test.com'}

    
  @tag4
  Scenario: Create Same User with Same Email Again - Error Message POST

    Given url apiURL + 'user'
	And request { email: 'test2@test.com' , name: 'Test User 3'}
    When method post
    Then  print responseStatus
	  And assert responseStatus >= 400
	  
    
  @tag5
  Scenario: Create Same User with Same Name Again POST status 201
    
    Given  url apiURL + 'user'
	And request { email: 'test3@test.com' , name: 'Test User 2'}
    When method post
    Then status 201
        
        
  @tag6
  Scenario: Get All Users GET

    Given url  apiURL + 'user/all'
    When method get
  	Then status 200
    And match $ contains {"name":"Test User 2","id":"#notnull","bookings":[],"email":"test2@test.com"}
