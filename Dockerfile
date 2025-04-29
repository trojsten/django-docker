FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app
RUN useradd --create-home appuser

ENV PYTHONUNBUFFERED=1
ENV PYTHONFAULTHANDLER=1

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -y caddy git xz-utils \
    && apt -y upgrade \
    && apt -y clean \
    && rm -rf /var/lib/apt/lists/*

ARG MULTIRUN_VERSION=1.1.3
ADD https://github.com/nicolas-van/multirun/releases/download/${MULTIRUN_VERSION}/multirun-x86_64-linux-gnu-${MULTIRUN_VERSION}.tar.gz /tmp
RUN tar -xf /tmp/multirun-x86_64-linux-gnu-${MULTIRUN_VERSION}.tar.gz \
    && mv multirun /bin \
    && rm /tmp/*

RUN chown appuser:appuser /app

ENV PATH="/app/.venv/bin:$PATH"
ENV WEB_CONCURRENCY=4
USER appuser

COPY base /base
CMD ["/base/start.sh"]
