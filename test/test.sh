set -e

export ANSI_YELLOW="\e[1;33m"
export ANSI_GREEN="\e[32m"
export ANSI_RESET="\e[0m"

echo -e "\n $ANSI_YELLOW *** testing docker run - kafka *** $ANSI_RESET \n"

echo -e "$ANSI_YELLOW feed/read output from consumer: $ANSI_RESET"

docker run --name apache_kafka -p 2081:2081 -p 9092:9092 -d quay.io/ibm/kafka:2.5
sleep 1m

docker exec apache_kafka bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic simple-test-topic
sleep 2

docker exec apache_kafka bin/kafka-topics.sh --list --bootstrap-server localhost:9092
sleep 2

docker exec -i apache_kafka bin/kafka-console-producer.sh < sonnet-XVIII.txt --bootstrap-server localhost:9092 --topic simple-test-topic
sleep 2

docker exec apache_kafka bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic simple-test-topic --from-beginning --timeout-ms 2000

echo -e "\n $ANSI_GREEN *** TEST COMPLETED SUCESSFULLY *** $ANSI_RESET \n"
