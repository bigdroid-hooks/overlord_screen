#           Variables - BigDroid Internals
#           - Only for advanced scripting -
#           ###############################
#
#   BASE_DIR            % The root dir where you find files like: bigdroid, bin, src.
#                       % Hope it explains the rest.
#               
#   SRC_DIR             % The 'src' dir under BASE_DIR.
#   
#   HOOKS_DIR           % The 'hooks' dir under BASE_DIR.
#   
#   HOOK_BASE           % This variable points to the root-dir
#                       % of a bigdroid every hook which is being run.
#   
#   MOUNT_DIR           % The parent dir which holds other child mountpoint dirs.
#                       % Followed by: system, secondary_ramdisk, initial_ramdisk and install_ramdisk.
#                       % We also have SYSTEM_MOUNT_DIR, SECONDARY_RAMDISK_MOUNT_DIR
#                       % INITIAL_RAMDISK_MOUNT_DIR and INSTALL_RAMDISK_MOUNT_DIR variables.
#   
#   ISO_DIR             % Your configured ISO by the '--setup-iso' argument is cached in this dir.
#   
#   BUILD_DIR           % This dir is used as the temporary boilerplate while building an ISO/IMAGE.
#   
#   TMP_DIR             % You can use this dir for storing temporary files.
#                       % It's more like '/tmp' as in your linux distro.
#
#   OVERLAY_DIR         % The overlay dir under BASE_DIR
#   
#   DISTRO_NAME         % Your android distro name as per 'hooks/distro.sh' or the defaults.
#   
#   DISTRO_VERSION      % Your android distro version as per 'hooks/distro.sh' or the defaults.
#
#   @@ Protip: Take a look at 'src/main.sh'.



#           General Functions - BigDroid Utils
#              - For easy hooks scripting -
#           ##################################
#
#   gclone              % Copy files preserving all their attrs with progress indicator.
#                       % Example: `gclone "$HOOK_BASE/myfile.txt" "$SYSTEM_DIR/lib64"`
#   
#   wipedir             % Easily wipe/empty a dir(childs) without removing it's parent.
#                       % Example: `wipedir "$MOUNT_DIR_INSTALL_RAMDISK/grub"`
#   
#   @@ Protip: Take a look at 'src/utils.sh'
#
#
#
#
#             libgearlock - GearLock utils
#     - Some native gearlock vars and functions -
#           ###############################
#
#   %% Simply take a look at 'src/libgearlock.sh' to know 
#   %% which gearlock variables and functions are available for use.



#               An example hook script
#           - To give you some quick idea -
#           ###############################

## Okay so here we go...
## Basically if you wanna start with this example script,
## then copy this `example_hook` dir into `hooks/` dir.
## Then start up editing it's `bd.hook.sh`.

# Now I want to merge my own hw files there from my HOOK_BASE (hooks/example_hook).
ADD_CUSTOM_GHOME_HOOK_BASE="$(hook::fetch_path "custom_ghome")/ghome/dependencies/assets/essential-user-apps"
gclone "$HOOK_BASE/app.apk" "$ADD_CUSTOM_GHOME_HOOK_BASE/OVERLORD.apk" || exit
# Now let's wait in a subprocess until `add_custom_ghome` is done

(
	hook::wait_until_done add_custom_ghome
	rm "$ADD_CUSTOM_GHOME_HOOK_BASE/OVERLORD.apk"

) &

# More things you do .........
