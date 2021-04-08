
@tag
Feature: Test Booking via GET POST


  @tag1
  Scenario: Verify booking by date and id status 200 - empty response
    
    Given url apiURL + 'booking' 
    And request {  id: 'pepe@pepe.pe1-0.2',    date: '2021-07-05' }
    When method get
    Then status 200
    
    
  @tag2
  Scenario: Verify booking by id status 200 - empty response
    
    Given  url apiURL +  'booking'
		And request { id: 'pepe@pepe.pe1-0.2' }
    When method get
    Then status 200
    
    
  @tag3
  Scenario: Verify booking by idUser (just a guess since id doesn't work) status 200 - empty response
 
    Given url apiURL + 'booking' 
    And request {  idUser: 'pepe@pepe.pe1-0.2' }
    When method get
    Then status 200
    
    
  @tag4
  Scenario: Verify booking by date (as defined in Swagger this should work as well) Status 200 - empty response
    
    Given  url apiURL +  'booking'
		And request { date: '2021-07-05' }
    When method get
    Then status 200
    
    
  @tag5
  Scenario: Verify booking by id and empty date status 200 - empty response
  
    Given url apiURL + 'booking' 
    And request {  id: 'pepe@pepe.pe1-0.2',    date: '' }
    When method get
    Then status 200
    
    
  @tag6
  Scenario: Verify user id should be valid status 400
    
    Given url apiURL +  'booking'
		And request { id: '12345', date: '2022-04-04' }
    When method get
    Then status 400
    And match $ contains 'User id should be valid'
    
    
  @tag7
  Scenario: Verify date should be valid status 400
    
    Given url apiURL +  'booking'
		And request { id: 'pepe@pepe.pe1-0.2', date: '2082-04-04' }
    When method get
    Then status 400
    And match $ contains 'Date should be valid'

      
  @tag8
  Scenario: Making a successful booking status 201 POST
    
    Given url apiURL +  'booking'
		And request {   date: '2021-07-05',   destination: 'TKY',   id: 'pepe@pepe.pe1-0.2',  origin: 'SFO' }
    When method post
    Then status 201
    And match $ contains { idBooking: '#notnull',  date: '2021-07-05',   destination: 'TKY',   idUser: 'pepe@pepe.pe1-0.2',  origin: 'SFO' }
    And  def bookingId =  response.idBooking
    And print bookingId

  
  @tag9
  Scenario: Verify booking by id - status 200 - booking details from tag8 test
  
    Given url apiURL +  'booking'
		And request { id: 'pepe@pepe.pe1-0.2' }
    When method get
    Then status 200 
    And match $ contains {date: '2021-07-05',  idBooking: '#notnull', destination: 'TKY',   idUser: 'pepe@pepe.pe1-0.2',  origin: 'SFO'}
     
   
  @tag10
  Scenario: Verify booking by date - status 200 - booking details from tag8 test
  
    Given url apiURL +  'booking'
		And request { date: '2021-07-05' }
    When method get
    Then status 200 
    And match $ contains {date: '2021-07-05', idBooking: '#notnull',  destination: 'TKY',   idUser: 'pepe@pepe.pe1-0.2',  origin: 'SFO'}    
    
    
  @tag11
  Scenario: Verify booking by date and id - status 200 - booking details from tag8 test
  
    Given url apiURL +  'booking'
		And request { id: 'pepe@pepe.pe1-0.2', date: '2021-07-05' }
    When method get
    Then status 200 
    And match $ contains {date: '2021-07-05', idBooking: '#notnull'  destination: 'TKY',   idUser: 'pepe@pepe.pe1-0.2',  origin: 'SFO'}
    
	@tag12
  Scenario: Making a booking with non existing user status 400+ POST
    
    Given url apiURL +  'booking'
		And request {   date: '2021-08-06',   destination: 'TKY',   id: '1233',  origin: 'SFO' }
    When method post
    Then print responseStatus 
    And assert responseStatus >= 400



	@tag13
  Scenario: Verify booking by date and id - status 400+ - booking details from tag12 (previous) test
  
    Given url apiURL +  'booking'
		And request { id: '1233', date: '2021-08-06' }
    When method get
    Then print responseStatus 
    And assert responseStatus >= 400
    
    
  @tag14
  Scenario: Making a booking in the past status  POST
    
    Given url apiURL +  'booking'
		And request {   date: '2020-07-05',   destination: 'MLN',   id: 'pepe@pepe.pe1-0.2',  origin: 'VIE' }
    When method post
    Then print responseStatus 
    And assert responseStatus > 201
  

  