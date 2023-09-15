TODO
----

During the installation of some apps, a link to private resources (files and folders) is created. These resources are not part of this (public) repository. The link's source is therefore not a file or folder in this repository. Instead, it is a file or folder inside the `.secrets` folder in the user's home folder (i.e., `~/.secrets/`).

To inform the user, which files and folders are required inside (`~/.secrets/`), two things are done:

* During the installation process, a [TODO] tag is shown, which includes the source that must still be created.

* An empty file is created in this folder (i.e., the folder where this `todo.md` file is located) with the same name as the file or folder. 

By comparing the contents of this folder with the contents of `~/.secrets/`, the user can quickly see, which resources are still missing.
