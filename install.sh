#!/bin/zsh

# local_up - start local from anywhere
echo "alias local_up=docker-compose -f $PWD/docker-compose.yml up -d" >> ~./zshrc

# local_up - start local session from anywhere
echo "alias local=docker-compose -f $PWD/docker-compose.yml exec zsh" >> ~./zshrc

# local_up - sstop local from anywhere
echo "alias local_down=docker-compose -f $PWD/docker-compose.yml down" >> ~./zshrc

source ~/.zshrc