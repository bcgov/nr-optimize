FROM docker-remote.artifacts.developer.gov.bc.ca/confluentinc/cp-kafka-rest:6.1.1
WORKDIR /src
COPY ["helloworld.py", "./"]
RUN apk add --no-cache python3 py3-pip
ENTRYPOINT ["python3", "helloworld.py"]