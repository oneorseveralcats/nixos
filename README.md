# NixOS and Home-Manager configuration

My configuration for the NixOS and Home-Manager.

NixOS is a Linux distro where the system state (packages, services, configurations)
is built from a declarative configuration. Nix has an awareness of the entire state
of the system and builds that state from a configuration system rather than executing
a set of operations (like Ansible).

Home-Manager is an extension of NixOS that manages packages, services, and their
configurations on a per-user basis. Configuring things via the NixOS configuration
are specific to NixOS, while Home-Manager can be installed on devices using the nix
package manager that aren't NixOS (e.g. other Linux distros, MacOS, Windows via
WSL2, Android via the app nix-on-droid).

My general approach to system configuration is doing everything possible in
Home-Manager because that config can be used on other platforms. The only things
done via the NixOS config are things that are required to be configured at the
system level.


