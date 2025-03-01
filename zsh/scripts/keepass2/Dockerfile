FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
	keepass2 \
	x11-apps \
	&& rm -rf /var/lib/apt/lists/*

# Set environment variable for the display
ENV DISPLAY=host.docker.internal:0

