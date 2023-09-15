# dotfiles

## Structure

```
dotfiles/
├── shared.sh   # functionality used across install files
├── install     # installs apps; run './install.sh -h' for more information
├── part1       # text file with app folder names (to install at once)
│
├── app_folder1/      # One folder per application
│    └── install.sh   # installs the app and its configuration, creates symlinks, etc.
│
├── app_folder2/
│    ├── install.sh
│    ├── bashrc.symlink           # File name ends in `.symlink` if a symlink to it will be created by the install script.
│    ├── aliases.symlink/         # The same goes for folders.
│    └── (no secrets here)        # Password files etc are not stored in this public repository. Instead, the install script
│                                 # creates a symlink to a file in the secrets/ folder. This folder does not exist...
├── secrets/                      # ...but is itself a symlink to a folder somewhere else on the filesystem.
│
.
.
```

There is one folder per application.

Each folder contains an `install.sh` script, which installs the necessary software, creates the necessary symlinks, etc. It is not called directly by the user.

In the root, there is a `shared.sh` file, which contains some functionality used in the individual `install.sh` files. This file is also not called directly by the user.

## Development

When adding an application, copy the `.template` folder, an example file can be found inside.

Also add the foldername to `part1` or `part2` or (...), so that it is installed when running `./install.sh -r part1`.

## Usage

In the root, there is an `install` script, which is the only file you need to run.

- On Linux, run it from a bash terminal.

- On Windows, run it from git bash.

- On Mac, run it from a bash terminal

The script takes one or more app (=folder) names as arguments, and also allows for the usage of text files; see `./install -h` for help.

After the installer script has completed correctly, we need to handle the secret files and folders that handle private information such as passwords.

For this, we only need to check the `secrets` path inside the dotfiles repository; this is where the `install.sh` scripts look for the private files:

    ```
    ~/.config/espanso                                            # Location on filesystem where app looks for its data
    -->  .../local_dotfile_repository/secrets/espanso.symlink    # Symlink created by install.sh
    ```

**This `secrets` folder does not exist.** Best-practice is to add another symlink, to an accessible (non-public) folder containing the wanted secrets. Like so:

    ```
    .../local_dotfile_repository/secrets                         # The secrets folder does not exist...
    --> .../some_private_location/dotfiles_secrets               # ...and it is created by symlink.
    ```

This symlink chain is needed to reach 2 goals:

1. Have a pre-determined folder, within the dotfiles folder, where the scripts can expect to find private information.

2. Keep this data actually private by not storing the folder itself in the repository.

NB: the individual app's `install.sh` files are not meant to be called directly. To install the `app_folder1`, we don't run `./app_folder1/install.sh`, but rather `./install app_folder1`.

## Details / conventions

Even the target of a hidden file (e.g., `.bashrc`) will not start with a dot (and will be e.g. `bashrc.symlink`). This is to make them visible and distinct from other files.
