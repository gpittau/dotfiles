# Dotfiles

My TKL-Debian6 dotfiles.

## Why is this a git repo?

I've been using bash on-and-off for a long time (since Slackware Linux was distributed on 1.44MB floppy disks). In all that time, every time I've set up a new Linux or OS X machine, I've copied over my `.bashrc` file and my `~/bin` folder to each machine manually. And I've never done a very good job of actually maintaining these files. It's been a total mess.

I finally decided that I wanted to be able to execute a single command to "bootstrap" a new system to pull down all of my dotfiles and configs, as well as install all the tools I commonly use. In addition, I wanted to be able to re-execute that command at any time to synchronize anything that might have changed. Finally, I wanted to make it easy to re-integrate changes back in, so that other machines could be updated.

That command is [~/bin/dotfiles][dotfiles], and this is my "dotfiles" Git repo.

[dotfiles]: https://github.com/gpittau/dotfiles/blob/gpittau-2015/bin/dotfiles
[bin]: https://github.com/gpittau/dotfiles/tree/gpittau-2015/bin

## What, exactly, does the "dotfiles" command do?

It's really not very complicated. When [dotfiles][dotfiles] is run, it does a few things:

1. Git is installed if necessary, via APT or Homebrew (which is installed if necessary).
2. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
2. Files in `init` are executed (in alphanumeric order).
3. Files in `copy` are copied into `~/`.
4. Files in `link` are linked into `~/`.

Note:

* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executable shell scripts ([~/.dotfiles/bin][bin] is added into the path).
* Files in `source` get sourced whenever a new shell is opened (in alphanumeric order)..
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## Installation
### Turnkeylinux Debian6
Notes:

* Added package repositories for byobu
* If APT hasn't been updated/upgraded recently, it might be a minute before you see anything.
* You'll have to enter your password for sudo.

```sh
bash -c "$(curl -k -fsSL https://raw.githubusercontent.com/gpittau/dotfiles/IDE-2020/bin/dotfiles)" && source ~/.bashrc
```

## The "init" step
These things will be installed, but _only_ if they aren't already.

### Debian
* APT
  * sudo
  * git-core
  * tree
  * htop
  * tmux
  * byobu
  * ctags
  * vim


## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/gpittau/dotfiles/blob/gpittau-2015/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions
To keep things easy, the `~/.bashrc` and `~/.bash_profile` files are extremely simple, and should never need to be modified. Instead, add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/gpittau/dotfiles/tree/gpittau-2015/source). I even have a [fancy prompt](https://github.com/gpittau/dotfiles/blob/gpittau-2015/source/50_prompt.sh) that shows the current directory, time and current git/svn repo status.

## Scripts
In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [bash scripts][bin]. This includes [ack](https://github.com/petdance/ack), which is a [git submodule](https://github.com/gpittau/dotfiles/tree/gpittau-2015/libs).

* [dotfiles][dotfiles] - (re)initialize dotfiles. On Debian, it might ask for your password (sudo).
* [src](https://github.com/gpittau/dotfiles/blob/gpittau-2015/link/.bashrc#L6-15) - (re)source all files in `source` directory
* Look through the [bin][bin] subdirectory for a few more.

## Prompt
I think [my bash prompt](https://github.com/gpittau/dotfiles/blob/gpittau-2015/source/50_prompt.sh) is awesome. It shows git and svn repo status, a timestamp, error exit codes, and even changes color depending on how you've logged in.

Git repos display as **[branch:flags]** where flags are:

**?** untracked files
**!** changed (but unstaged) files
**+** staged files

SVN repos display as **[rev1:rev2]** where rev1 and rev2 are:

**rev1** last changed revision
**rev2** revision

Check it out:

## Inspiration
<https://github.com/gf3/dotfiles>
<https://github.com/mathiasbynens/dotfiles>
(and 15+ years of accumulated crap)

## License
Copyright (c) 2011 "Cowboy" Ben Alman
Licensed under the MIT license.
<http://benalman.com/about/license/>
