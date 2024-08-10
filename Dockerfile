FROM python:3.12-slim-bookworm

WORKDIR /app
RUN useradd --create-home appuser

ENV PYTHONUNBUFFERED=1
ENV PYTHONFAULTHANDLER=1

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -y caddy xz-utils \
    && apt -y upgrade \
    && apt -y clean \
    && rm -rf /var/lib/apt/lists/*

ARG MULTIRUN_VERSION=1.1.3
ADD https://github.com/nicolas-van/multirun/releases/download/${MULTIRUN_VERSION}/multirun-x86_64-linux-gnu-${MULTIRUN_VERSION}.tar.gz /tmp
RUN tar -xf /tmp/multirun-x86_64-linux-gnu-${MULTIRUN_VERSION}.tar.gz \
    && mv multirun /bin \
    && rm /tmp/*

RUN chown appuser:appuser /app

ENV POETRY_VIRTUALENVS_CREATE=0
RUN pip install --upgrade poetry
