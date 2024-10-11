# Build Orca-Slicer from appimage and install on Nix.

---

## Build and Install

```
nix build .#orcaslicer
nix profile install .#orcaslicer
```

# Trouble shooting tips

## Locale Error on start
I am running NixOs with the plasma desktop and had some issues with locale settings. I had to delete the ~/.config/plasma-localerc config file and logout and back in to not get the cannot switch locale error
