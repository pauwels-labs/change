FROM alpine:3.16

# Make change available in terminal
WORKDIR /usr/bin

# Fetch https://github.com/adamtabrams/change to handle
# semantic versioning/tagging/releasing
RUN apk update && apk add --no-cache git openssh curl
COPY change change
RUN chmod +x change
#RUN wget https://raw.githubusercontent.com/adamtabrams/change/0.14.4/change && sed -i 's/base64 --decode/base64 -d/' change && chmod +x change

# Create an unprivileged user
RUN adduser --disabled-password --home /notroot --uid 10000 notroot notroot
USER notroot:notroot

# Pre-create the git config file to prevent errors in CLI
RUN touch /notroot/.gitconfig

ENTRYPOINT ["./change"]
