video2gif() {
  ffmpeg -i "${1}" \
    -vf "fps=10,scale=1920:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 "${2}".gif
}

gifrec() {
  fileName=$1
  screencapture -viU $fileName
  videoFile=$(/bin/ls -Art ~/Desktop | tail -n 1)
  video2gif "${HOME}/Desktop/${videoFile}" $fileName
  rm "${HOME}/Desktop/${videoFile}"
}
