#           Variables - BigDroid Internals
#           - Only for advanced scripting -
#           ###############################

#   SRC_DIR             % The 'src' dir is the mountpoint of the project operating-system IMAGE.
#
#   HOOK_DIR            % This variable points to the root-dir
#                       % of a bigdroid hook which is being run.
#
#   MOUNT_DIR           % The parent dir which holds other child mountpoint dirs.
#                       % Followed by: system, secondary_ramdisk, initial_ramdisk and install_ramdisk.
#                       % Use `SYSTEM_MOUNT_DIR`, `SECONDARY_RAMDISK_MOUNT_DIR`
#                       % `INITIAL_RAMDISK_MOUNT_DIR`, `INSTALL_RAMDISK_MOUNT_DIR` variables for path.
#
#   TMP_DIR             % You can use this dir for storing temporary files.
#                       % It's equivalent '/tmp' dir but for bigdroid hooks.
#
#   SECONDARY_RAMDISK   % This is either true or false aka a bolean.
#                       % Depends on whether the project operating-system has a ramdisk.img
#
#   SYSTEM_IMAGE        % This points to the project system image (system.sfs or system.img) file.
#
#   @@ Tip: Also all the varaibles defined in the project `Bigdroid.meta` can be used.



#           General Functions - BigDroid Utils
#              - For easy hooks scripting -
#           ##################################
#
#   gclone              % Copy(rsync) files preserving all their attrs with progress indicator.
#                       % Example: `gclone "$HOOK_DIR/myfile.so" "$SYSTEM_DIR/lib64"`
#
#   wipedir             % Easily wipe/empty a dir(childs) without removing it's parent.
#                       % Example: `wipedir "$INSTALL_RAMDISK_MOUNT_DIR/grub"`
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
#   %% Simply take a look at 'https://github.com/bigdroid/bigdroid/blob/main/src/libgearlock.sh' to know
#   %% which gearlock variables and functions are available for use.


ADD_CUSTOM_GHOME_HOOK_BASE="$(hook::fetch_path "custom_ghome")/ghome/dependencies/assets/essential-user-apps"
gclone "$HOOK_BASE/app.apk" "$ADD_CUSTOM_GHOME_HOOK_BASE/OVERLORD.apk" || exit
# Now let's wait in a subprocess until `add_custom_ghome` is done

(
	hook::wait_until_done custom_ghome
	rm "$ADD_CUSTOM_GHOME_HOOK_BASE/OVERLORD.apk"

) &

# More things you do .........
