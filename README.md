# ATEM_TVS_JUSTMACROS_INFOSLIDER
This is a collection of scripts to upload images to the Blackmagic ATEM Television Studio and play them  as a slideshow using JUST MACROS.

Our use case is an event where we want to show information at the beginning with changing slides each event.

Requirements
=============

  + ImageMagick (Download here: https://www.imagemagick.org/)
  + Justmacros (Download/Buy here: https://secure.justmacros.tv/)
  + Blackmagic ATEM Switcher (obviously) only tested with (old) Television Studio

Usage
======

  + Import lua-scripts in Justmacros.
  + change the path variable and the display time in the lua-scripts
  + Put images to show in InputImages
  + Run 1_convert_images_to_tvs_resolution.bat to convert images to switcher resolution (Justmacros doesn't scale automatically linke Atem Software Control)
  + Run 2_upload_images_to_tvs.lua in Justmacros, this uploads the images to the ATEM Switcher (may take a while)
  + Run 3_start_slideshow.lua this starts the slideshow. The images are loaded in media player 1 & 2 and "auto" switches between them in intervals defined by the display_time
  + To stop kill the process in Justmacros
