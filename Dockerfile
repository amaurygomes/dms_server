FROM hexpm/elixir:1.16.2-erlang-25.0.2-debian-bookworm-20251117 AS builder

RUN apt-get update -y && apt-get install -y build-essential git postgresql-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

COPY apps/*/mix.exs apps/*/


COPY . .
