# dotfiles

## Structure


```
dotfiles/
├── shared.sh   # functionality used across install files
├── install.sh   # installs all - simply runs install.sh file in each app folder
│
├── app_folder1/   # One folder per application
│    └── install.sh   # installs the app and its configuration, creates symlinks, etc.
│
├── app_folder2/   
│    ├── install.sh
│    ├── bashrc.symlink  # File name ends in `.symlink` if a symlink to it will be created.
│    ├── aliases.symlink/  # The same goes for folders.
│    └── bashrc_password.private  #  If file name ends in `.private`, a symlink to it will 
│                                 #  also be created. However, in the public repository, this
│                                 #  file is empty and must be replaced.
.
.
```

There is one folder per application.

Each folder contains an `install.sh` script, which installs the necessary software, creates the necessary symlinks, etc.

In the root, there is a `shared.sh` file, which contains some functionality used in the individual `install.sh` files.

## Development

When adding an application, create a folder for it, and add an `install.sh` script. In the `template` folder, an example file can be found.

Also add the foldername to `order`, so that it is installed when running the `install.sh` script in the root.

## Usage

In the root, there is an `install.sh` script, which is the only file you need to run.

* In Linux, run it from the terminal.

* In Windows, run it from git bash with admin priviliges.

The script simply searches for the `install.sh` files in the subfolders, and executes them.

Whenever the `install.sh` script has completed correctly, we need to handle the `.private` files that handle private information such as passwords.

* If the repository is a private one, the `.private` files and folders will not be empty, and nothing needs to be done.

* If the repository was cloned from github or another public source, there will be no `.private` folders, only `.private` files, which are all empty and must be replaced. The replacement can be:

  - an identically named file or folder, copied over from a (non-public) source.

  - another symlink, to an accessible (non-public) file or folder. In this case, we get a symlink chain, e.g. 

    ```
    ~/.config/espanso  # location on filesystem
    -->  .../dotfile_repository/espanso/espanso.private  # symlink created by install.sh 
         -->  .../some_private_location/espanso.private/  # symlink created manually, later
    ```


## Details / conventions

Even the target of a hidden file (e.g., `.bashrc`) will not start with a dot (and will be e.g. `bashrc.symlink`). This is to make them visible and distinct from other files.



