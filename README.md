# NRT App

This app NRT performs the following operations using Confluent REST Proxy:

## Producing and Auto-Creating a Topic

To produce a message and auto-create a topic, use the following `curl` command:

```bash
curl -X POST http://localhost:8082/topics/my-topic \
     -H "Content-Type: application/vnd.kafka.json.v2+json" \
     -d '{"records":[{"value":{"key":"value"}}]}'
```


## Create a Consumer Instance
To create a consumer instance, use the following curl command:

```bash
curl -X POST http://localhost:8082/consumers/my_consumer_group \
     -H "Content-Type: application/vnd.kafka.v2+json" \
     -d '{"name": "my_consumer_instance", "format": "json", "auto.offset.reset": "earliest"}'
```


## Subscribe the Consumer to the Topic
To subscribe the consumer to the topic, use the following curl command:

```bash
curl -X POST http://localhost:8082/consumers/my_consumer_group/instances/my_consumer_instance/subscription \
-H "Content-Type: application/vnd.kafka.v2+json" \
-d '{"topics":["my-topic"]}'
```


## Consume Messages from the Topic
To consume messages from the topic, use the following curl command:

```bash
curl -X GET http://localhost:8082/consumers/my_consumer_group/instances/my_consumer_instance/records \
-H "Accept: application/vnd.kafka.json.v2+json"
```

## Notes
Replace localhost:8082 with the actual address of your REST Proxy server if it’s different.

Ensure that the Kafka REST Proxy is running and accessible at the specified address.

