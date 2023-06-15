FROM alpine:3.16

# Make change available in terminal
WORKDIR /usr/bin

# Fetch https://github.com/adamtabrams/change to handle
# semantic versioning/tagging/releasing
RUN apk update && apk add --no-cache git openssh curl
COPY change change
RUN chmod +x change

# Create an unprivileged user
RUN adduser --disabled-password --home /notroot --uid 10000 notroot notroot
USER notroot:notroot

# Pre-create the git config file to prevent errors in CLI
RUN touch /notroot/.gitconfig

ENTRYPOINT ["./change"]
