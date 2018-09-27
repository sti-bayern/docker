# `akilli/base`

A quite minimal base image built from `alpine:latest` with pre-installed `s6` package, `crond`-support, configured locale (default: `de_DE.UTF-8`) and timezone (default: `Europe/Berlin`), a user and group named `app` with UID/GID `1000` as well as the custom directories `/app`, `/data`, `/home/app` and `/var/log/app` owned by user `app`.

A default entrypoint `app-entry` is provided and ensures proper ownership of the custom directories before executing the passed `CMD` command (default: `s6-svscan /etc/s6`). The pre-configured `s6` scan directory is `/etc/s6`. Please see the other `akilli` images that are all derived from this image.
