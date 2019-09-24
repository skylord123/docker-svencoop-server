# docker-svencoop-server
Run a Sven Co-op dedicated server in Docker!

Created by: skylord123 https://github.com/skylord123

Running the container
---------------------------

Running the container is super easy. Just run this command:
```
docker run --name skylord123/svencoop-server -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_PORT=27015' \
	--env 'GAME_PARAMS=+maxplayers 12 +map osprey +log on -num_edicts 8192' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /mnt/user/appdata/steamcmd:/serverdata/steamcmd \
	--volume /mnt/user/appdata/cstrikesource:/serverdata/serverfiles \
	skylord123/svencoop-server:latest
```
This command will store steamcmd and serverfiles folders inside `/mnt/user/appdata` which is nice if you are on Unraid but if you are on another system you may want to change this to somewhere else.

License
---------------------------
We currently use the GNU GENERAL PUBLIC LICENSE. Check the license file for more information.
