# For more information, please refer to https://aka.ms/vscode-docker-python
FROM mcr.microsoft.com/devcontainers/python:3.11
# FROM python:3.11

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Ignore non-root pip usage
ENV PIP_ROOT_USER_ACTION=ignore

#
# RUN apt-get -y update && apt-get -y upgrade
RUN python -m pip install -U wheel setuptools pip
RUN python -m pip install swig

# Install pip requirements
COPY requirements.txt /tmp/pip-tmp/
RUN python -m pip --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
    && rm -rf /tmp/pip-tmp

WORKDIR /app
# COPY . .

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
# RUN adduser -u 5678 --disabled-password --gecos "" appuser && \
#     chown -R appuser /app
# USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["/bin/zsh"]
