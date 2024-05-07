# Bluefin and Aurora
**These images are managed versions of their upstream counterparts.** 

## Bluefin - [projectbluefin.io](https://projectbluefin.io)

[![bluefin 39](https://github.com/APoorDev/bluefin/actions/workflows/build-39-bluefin.yml/badge.svg)](https://github.com/APoorDev/bluefin/actions/workflows/build-39-bluefin.yml) [![bluefin 40](https://github.com/APoorDev/bluefin/actions/workflows/build-40-bluefin.yml/badge.svg)](https://github.com/APoorDev/bluefin/actions/workflows/build-40-bluefin.yml)

## Aurora - [getaurora.dev](https://getaurora.dev)

[![aurora 39](https://github.com/APoorDev/bluefin/actions/workflows/build-39-aurora.yml/badge.svg)](https://github.com/APoorDev/bluefin/actions/workflows/build-39-aurora.yml) [![aurora 40](https://github.com/APoorDev/bluefin/actions/workflows/build-40-aurora.yml/badge.svg)](https://github.com/APoorDev/bluefin/actions/workflows/build-40-aurora.yml)

## Secure Boot

Secure Boot is supported by default on our systems, providing an additional layer of security. After the first installation, you will be prompted to enroll the secure boot key in the BIOS.

Enter the password `ublue-os` 
when prompted to enroll our key.

If this step is not completed during the initial setup, you can manually enroll the key by running the following command in the terminal:

`
ujust enroll-secure-boot-key
`

Secure boot is supported with our custom key. The pub key can be found in the root of the bazzite repository [here](https://github.com/ublue-os/bazzite/blob/main/secure_boot.der).
If you'd like to enroll this key prior to installation or rebase, download the key and run the following:

```bash
sudo mokutil --timeout -1
sudo mokutil --import secure_boot.der
```

### Note:
If you encounter an issue with a password being recognized as incorrect, try using the `-` key on the numpad instead.
