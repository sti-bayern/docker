# `akilli/base`

Base image with `tini`, `su-exec`, timezone and a user and group named `app` with UID/GID `1000`.

Creates the `/app`, `/data` and `/var/log/app` directories. `app-entry` is added as entrypoint and ensures proper
 ownership of those directories. `app-entry` is invoked by `tini`. It executes `app-init` if this executable exists 
 before executing the passed `CMD` command. You can use `su-exec` in the `CMD` command of you derived image if necessary. 
 Please see the other `akilli` images that are all derived from this image.
