FROM ccn4/api:build-internet as builder
#permet de faire les images de nom ccn4/api:1.0.1

RUN rm /app/app.py

COPY app.py /app
COPY dockercopie.py /app
COPY DockerDynamiqueIpPortBind.py /app
COPY DockerDynamiqueIpVolBind.py /app

CMD ["python3.6","app.py"]

