# Local

Dev local image with tools I use day-to-day at work. 

This prevents me from having to worry about version mismatching, my laptop breaking and having to start installing all over, volumes for the data I need to persists from run to run are mounted, and most importantly, when something breaks I can just stop the process and start over. 

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
- jq
- maven
- glcoud comonents
- bigtable emulator
- node
- terraform
- scala
- sbt
- go
- protobuf

## Requirements

- Docker, tested with Version 2.0.0.0-mac78 (28905)

## Setup

### Docker Compose

If you plan to use Docker Compose (vs plain ol Docker commands), there is a template provided in `docker-compose.example.yml`. 

First copy the file
`$ cp docker-compose.example.yml docker-compose.yml`

If you have your computer (host) files organized in the same fashion as mine, you're good to go. Otherwise you'll want to edit the volumes in `docker-compose.yml` to mount the volumes where you have them saved.

It is important to mount the volumes, as anything stored on a non-mounted volume will be lost when you turn off the process.

### Aliases (optional)

Completely optional and assumes you are using zsh.

From the local project root, run `./install.sh`

Now you have the aliases
- `local_up` - start local
- `local_exec` - start local session
- `local_down` - stop local

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
docker-compose build --no-cache # Note the --no-cache, apt-update can get skipped is this isn't used
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

### Troubleshooting

### Volumes keep mounting as empty

If you are using the host machine docker daemon, it is important to remember the volume paths are relative to the host machine.

### How do I expose adhoc ports to the host machine

Say you decide you decide to run an application that exposes a UI on a certain port and you want to access it from your web browser of choice on your host machine. What do you do? Well, you have to restart the container with the port properly exposed. Pretty lame. A way to get around this is to run the application in a container with the port exposed. If these seems obvious, then good. You can move along. If you're a bit confused,

### Git/SSH bad configurations error
```
2fae441106bb# git push
/root/.ssh/config: line 3: Bad configuration option: usekeychain
/root/.ssh/config: terminating, 1 bad configuration options
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Solution

Update `~/.ssh/config`

```
 Host *
  AddKeysToAgent yes
+ IgnoreUnknown UseKeychain
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

#### Keep getting prompted for ssh passphrase

*WARNING*: Hasn't been validated

Enter passphrase for key '/root/.ssh/id_rsa':

```
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
```