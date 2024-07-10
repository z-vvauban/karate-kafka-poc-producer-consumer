Feature: Kafka REST Proxy Test

  Background:
    * url 'http://localhost:8082'

  Scenario: Produce and consume messages from Kafka topic

    # Step 1: Produce a message to the topic
    Given path 'topics/my-topic'
    And request { records: [{ value: { key: 'value' } }] }
    And header Content-Type = 'application/vnd.kafka.json.v2+json'
    When method post
    Then status 200

    # Step 2: Create a consumer instance
    Given path 'consumers/my_consumer_group'
    And request { name: 'my_consumer_instance', format: 'json', 'auto.offset.reset': 'earliest' }
    And header Content-Type = 'application/vnd.kafka.v2+json'
    When method post
    Then status 200

    # Step 3: Subscribe the consumer to the topic
    Given path 'consumers/my_consumer_group/instances/my_consumer_instance/subscription'
    And request { topics: ['my-topic'] }
    And header Content-Type = 'application/vnd.kafka.v2+json'
    When method post
    Then status 204

    # Step 4: Consume messages from the topic
    Given path 'consumers/my_consumer_group/instances/my_consumer_instance/records'
    And header Accept = 'application/vnd.kafka.json.v2+json'
    When method get
    Then status 200
    And match response[0].value == { key: 'value' }
