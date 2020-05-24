#!/bin/zsh

# local_build - build local from anywhere
echo "alias local_build=\"docker-compose -f $PWD/docker-compose.yml build --no-cache\"" >> ~/.zshrc

# local_up - start local from anywhere
echo "alias local_up=\"docker-compose -f $PWD/docker-compose.yml up -d\"" >> ~/.zshrc

# local_exec - start local session from anywhere
echo "alias local_exec=\"docker-compose -f $PWD/docker-compose.yml exec zsh\"" >> ~/.zshrc

# local_down - stop local from anywhere
echo "alias local_down=\"docker-compose -f $PWD/docker-compose.yml down\"" >> ~/.zshrc

source ~/.zshrc