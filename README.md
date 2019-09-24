# docker-svencoop-server
Run a [Sven Co-op](https://www.svencoop.com/) dedicated server in Docker!

Created by: skylord123 https://github.com/skylord123  
Docker Hub: https://hub.docker.com/r/skylord123/svencoop-server  
GitHub: https://www.github.com/skylord123/docker-svencoop-server

I couldn't get any of the other containers working so I decided to make my own.
If you have never heard of Sven Co-op I highly recommend you check it out. It's an awesome game and it's now [free on Steam](https://store.steampowered.com/app/225840/Sven_Coop/).

Running the container
---------------------------

Running the container is super easy. Just run this command:
```
docker run --name skylord123/svencoop-server -d \
	-p 27015:27015 -p 27015:27015/udp \
	--env 'GAME_PORT=27015' \
	--env 'GAME_PARAMS=+maxplayers 12 +map osprey +log on -num_edicts 8192' \
	--env 'VALIDATE=true'
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /mnt/user/appdata/steamcmd:/serverdata/steamcmd \
	--volume /mnt/user/appdata/svencoop:/serverdata/serverfiles \
	skylord123/svencoop-server:latest
```
This command will store steamcmd and serverfiles folders inside `/mnt/user/appdata` so if you want them stored elsewhere on the host make sure you change this (this was developed on Unraid which uses these paths).

If you run multiple containers make sure to share the steamcmd folder between them but have unique serverfiles folders.

After running the command steamcmd will start downloading the Sven Co-op dedicated server. Once that is finished it will launch the server and you should see the console output in your log.

Env Options:
- `GAME_PORT` - Game port for the server. Make sure this matches the port that users will use to connect or you may have issues (see below for more details)
- `GAME_PARAMS` - Enter your arguments for `svends_run` (see above for example).
- `VALIDATE` - Set the Variable to 'true' if you want to validate the installation otherwise leave it blank or set it to `false`.
- `USERNAME` and `PASSWORD` - Steam user/pass for downloading (uses anonymous if not defined which works with Sven co-op so this is not necessary)


## Known Issues
#### All ports must match
Make sure that `GAME_PORT` matches the same port that clients will be connecting from otherwise you will get strange issues (even though it works).

Example: If you map `GAME_PORT` to 27015 (default) and then map it to 27016 on the host it will cause issues when clients try to add the server to their favorites (it will be added with whatever port the server is configured with in `GAME_PORT` even though it's really on another port).


## Report Issues or do Feature Requests
Issues and feature requests can be created from the [issues](https://github.com/skylord123/docker-svencoop-server/issues) tab on github.

License
---------------------------
We currently use the GNU GENERAL PUBLIC LICENSE. Click [here](https://github.com/skylord123/docker-svencoop-server/blob/master/LICENSE) for more information.
