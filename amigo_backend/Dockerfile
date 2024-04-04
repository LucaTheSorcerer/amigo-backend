# Start with an Erlang base image
FROM erlang:26.2.2

# Install dependencies required by asdf and Elixir
RUN apt-get update && \
    apt-get install -y --no-install-recommends git curl autoconf dirmngr gpg gpg-agent bash && \
    apt-get install -y postgresql-client inotify-tools && \
    apt-get install -y build-essential && \
    rm -rf /var/lib/apt/lists/*

#RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
#RUN bash nodesource_setup.sh
#RUN apt-get install -y nodejs npm

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install asdf
ENV ASDF_VERSION="v0.10.0"
RUN git clone https://github.com/asdf-vm/asdf.git /opt/asdf --branch $ASDF_VERSION

# Make sure to use bash for RUN commands
SHELL ["/bin/bash", "-c"]

# Install Elixir using asdf
ENV ELIXIR_VERSION="1.16.2"
RUN . /opt/asdf/asdf.sh && \
    asdf plugin add elixir && \
    asdf install elixir $ELIXIR_VERSION && \
    asdf global elixir $ELIXIR_VERSION

ENV LANG=C.UTF-8

# Install Hex and Rebar
RUN . /opt/asdf/asdf.sh && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

COPY mix.exs mix.lock ./

RUN . /opt/asdf/asdf.sh && \
    mix deps.get

COPY . .



RUN . /opt/asdf/asdf.sh && \
    mix do compile


COPY run.sh ./run.sh
RUN chmod +x ./run.sh

EXPOSE 4000

#CMD ["bash", "-c", ". /opt/asdf/asdf.sh && mix phx.server"]

#CMD ["./run.sh"]