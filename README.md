# dotfiles

## Structure

```
dotfiles/
├── shared.sh   # functionality used across install files
├── install     # installs apps; run './install -h' for more information
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
│                                 # creates a symlink to a file or folder in the ~/.secrets/ folder (so, in the user's home
│                                 # folder). In order to inform the user, which files and folders are used as the source of
│                                 # a symlink, a message is displayed during the installation process...
├── secrets/                      # ...and also, an empty text file with the same name is created in this folder. The user
│                                 # can compare its contents with that of `~/.secrets/`, to see if anything is missing.
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

NB: the individual app's `install.sh` files are not meant to be called directly. To install the `app_folder1`, we don't run `./app_folder1/install.sh`, but rather `./install app_folder1`.

### Secrets

After the installer script has completed correctly, we need to handle the secret files and folders that contain private information such as passwords.

For this, we can check the `secrets` folder inside the dotfiles repository. Let's say the following symlink is created:

    ```
    ~/.config/espanso                                            # Location on filesystem where app looks for its data
    -->  ~/.secrets/espanso.symlink                              # Symlink created by install.sh
    ```

Then, the script also created an empty textfile with the same name in the `dotfiles/secrets/` folder:

    ```
    .../this_dotfiles_repository/secrets/espanso.symlink         # empty textfile
    ```

This file serves as a reminder, which resources are expected. He can go to the `~/.secrets/` folder (create it if not yet existing), and create the resource called (`espanso.symlink`) inside it.

Of course, the user can also create a (secondary) symlink from elsewhere. Or, instead of creating the `~/.secrets/` folder, he can symlink to the entire folder from elsewhere as well.

## Details / conventions

Even the target of a hidden file (e.g., `.bashrc`) will not start with a dot (and will be e.g. `bashrc.symlink`). This is to make them visible and distinct from other files.
