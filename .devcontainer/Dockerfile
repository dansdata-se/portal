# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.241.1/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): bullseye, buster
ARG VARIANT="bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
ARG VARIANT
ARG POSTGRES_VERSION="14"
ARG SUPABASE_CLI_VERSION="1.8.4"
ARG TBLS_VERSION="1.56.9"

# Generic requirements
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive\
    && apt-get -y install --no-install-recommends\
    libcurl4-openssl-dev\
    ca-certificates\
    gnupg

# Install supabase CLI
COPY supabase_${SUPABASE_CLI_VERSION}_checksums.txt .
ADD https://github.com/supabase/cli/releases/download/v${SUPABASE_CLI_VERSION}/supabase_${SUPABASE_CLI_VERSION}_linux_amd64.deb .
RUN sha256sum -c supabase_${SUPABASE_CLI_VERSION}_checksums.txt 2>&1 | grep OK\
    && dpkg -i supabase_${SUPABASE_CLI_VERSION}_linux_amd64.deb

# Install libffi6 (required by the `ms-ossdata.vscode-postgresql` vscode extension)
COPY buster-sources.list /etc/apt/buster-sources.list
RUN echo "APT::Default-Release \"${VARIANT}\";" >> /etc/apt/apt.conf.d/99buster\
    && cat /etc/apt/buster-sources.list >> /etc/apt/sources.list\
    && apt-get update\
    && export DEBIAN_FRONTEND=noninteractive\
    && apt-get -y install --no-install-recommends -t buster\
    libffi6

# Install postgresql-client matching supabase version.
#
# Apparently, http://deb.debian.org/debian has priority 990, making it impossible
# to install non-${VARIANT} postgres. Use custom preference file as workaround:
# https://www.postgresql.org/message-id/CAGYT1XQe3vKnbbrJMAoOhR%3D-%3Dpm8KoiSu0cegfanw%3Dk9oJwxuw%40mail.gmail.com
COPY pgdg.pref /etc/apt/preferences.d/pgdg.pref
RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg >/dev/null\
    && echo "deb http://apt.postgresql.org/pub/repos/apt ${VARIANT}-pgdg main ${POSTGRES_VERSION}" > /etc/apt/sources.list.d/pgdg.list\
    && apt-get update\
    && export DEBIAN_FRONTEND=noninteractive\
    && apt-get -y install --no-install-recommends\
    postgresql-client-${POSTGRES_VERSION}\
    pgformatter

# Install [tbls](https://github.com/k1LoW/tbls) for graph visualization
ADD https://github.com/k1LoW/tbls/releases/download/v${TBLS_VERSION}/tbls_${TBLS_VERSION}-1_amd64.deb /tmp/tbls.deb
RUN dpkg -i /tmp/tbls.deb
