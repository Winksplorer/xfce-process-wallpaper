#!/bin/bash
WALLPAPER_PATH="$(pwd)/wallpaper.png"

echo "Setting wallpaper..."

set_xfce_backdrop() {
  image_path=$1
  command=("xfconf-query" "-c" "xfce4-desktop" "-l")

  while true
  do
    output=$( "${command[@]}" 2>&1 )
    success=$?
    if [ $success -ne 0 ]; then
      echo "Error fetching properties: $output"
      return
    fi

    properties=($output)
    target_properties=()
    for property in ${properties[*]}
    do
      if [[ $property == /backdrop/* ]] && [[ $property == *last-image* ]]
      then
        target_properties+=( $property )
      fi
    done

    if [ ${#target_properties[@]} -eq 0 ]
    then
      break
    fi

    for target_property in ${target_properties[*]}
    do
      command=("xfconf-query" "-c" "xfce4-desktop" "-p" $target_property "-s" $image_path)
      output=$( "${command[@]}" 2>&1 )
      success=$?
      if [ $success -eq 0 ]; then
        echo "Backdrop image set successfully!"
      else
        echo "Error setting backdrop image: $output"
        continue
      fi
    done

    output=$( "${command[@]}" 2>&1 )
    properties_after_update=($output)

    all_without_last_image=true
    for property in ${properties_after_update[*]}
    do
      if [[ $property == *last-image* ]]
      then
        all_without_last_image=false
      fi
    done

    if [ "$all_without_last_image" = true ]
    then
      break
    fi
  done
}

set_xfce_backdrop $(pwd)/wallpaper.png

echo ""