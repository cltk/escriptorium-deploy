# escriptorium-deploy
Script(s) to deploy the [eScriptorium](https://gitlab.inria.fr/scripta/escriptorium) application.

## Requirements

Currently the script works on a fresh, stock Debian 10 system, whether running as the host OS, e.g. at a cloud provider, or under the excellent [Windows Subsystem for Linux v2 (WSL2)](https://docs.microsoft.com/en-us/windows/wsl/compare-versions#whats-new-in-wsl-2).

## Installation

Ensure you have `sudo` access to the system.  At the terminal, install `git`:

```shell
$ sudo apt update
$ sudo apt install git
```

Then grab the deployment script and run it.

```shell
$ git clone https://github.com/cltk/escriptorium-deploy.git
$ cd escriptorium-deploy
$ bash deploy.bash
```

It will run for some time.  At the end, you will be prompted to create a username and password for the administrative ("superuser") account on the system.

## Starting and stopping the application

Depending on where you installed the system, change to the subdirectory containing the application.

```shell
$ cd ~/escriptorium-deploy/escriptorium/app
```

Start the application:

```shell
$ cd python manage.py runserver 0.0.0.0:8000 --settings=escriptorium.local_settings
```

It it stopped via CTRL-C in the same terminal.

If running locally, the system should now be accessible at http://localhost:8000.


