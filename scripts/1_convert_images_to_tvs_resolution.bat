@ECHO OFF

REM empty the output folder to prevent conflicts
FOR %%f IN (InfoSlides\*) DO DEL "%%f"

REM # convert images to 1920x1080 resolution, keeps aspect ratio and fills empty space with black
magick convert "InputImages\*.png"   -resize 1920x1080 -background black -gravity center -extent 1920x1080 "I nfoSlides\SlidePNG.png"
magick convert "InputImages\*.jpg"   -resize 1920x1080 -background black -gravity center -extent 1920x1080 "InfoSlides\SlideJPG.png"
