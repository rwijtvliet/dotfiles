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
│    ├── bashrc.symlink           # File name ends in `.symlink` if a symlink to it will be created.
│    ├── aliases.symlink/         # The same goes for folders.
│    └── bashrc_password.private  #  If file name ends in `.private`, a symlink to it will
│                                 #  also be created. However, in the public repository, this
│                                 #  file is empty and must be replaced.
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

Whenever the `install.sh` script has completed correctly, we need to handle the `.private` files and folders that handle private information such as passwords.

For this, check the repository for files that end in `.private`. These are endpoints of symlinks created at various places on the filesystem. They are empty and need to be replaced. Best-practice: replace them with another symlink, to an accessible (non-public) file or folder. We then get a symlink chain, e.g.

    ```
    ~/.config/espanso  # location on filesystem
    -->  .../local_dotfile_repository/espanso/espanso.private    # symlink created by install.sh
         -->  .../some_private_location/espanso.private/         # symlink created manually, later
    ```

NB: the individual app's `install.sh` files are not meant to be called directly. To install the `app_folder1`, we don't run `./app_folder1/install.sh`, but rather `./install app_folder1`.

## Details / conventions

Even the target of a hidden file (e.g., `.bashrc`) will not start with a dot (and will be e.g. `bashrc.symlink`). This is to make them visible and distinct from other files.
