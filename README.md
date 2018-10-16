# Local

## High-Level Tools
- zsh
- git
- vim
- gcloud
- mysql client
- ssh
- nvm
- kubectl
- redis-cli

## Usage

Start docker-compose in dettached mode
```
$ docker-compose up -d
```

Open a terminal
```
$ docker-compose exec local zsh
```

## docker-compose

**NOTE** Some volumes mounted in docker-compose are specially catered to my preferred file storage locations.

### Build
```
docker-compose build
```

## Dockerfile

### Build

```
docker build -t local .
```

### Run
```
docker run --rm -it local
```