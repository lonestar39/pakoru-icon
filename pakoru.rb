#!/usr/bin/env ruby
require 'RMagick'

FONT = './font/GN-KillGothic-U-KanaNB.ttf' # fontは適当に
SIZE = 640

# パコる君風アイコンを作る
def create(str, output_file_name, outside_color, inside_color, str_color)
  point_size = 500/str.length
  cx = SIZE/2
  cy = SIZE/2

  # とりあえず画像を用意
  img = Magick::ImageList.new
  img.new_image(SIZE, SIZE){
    self.background_color = "none"
  }

  # 外側の円を書く
  dr1 = Magick::Draw.new 
  rx = SIZE/2
  ry = SIZE/2
  dr1.fill = outside_color
  dr1.ellipse(cx,cy,rx,ry,0,360)
  dr1.draw(img)

  # 内側の円を書く
  dr2 = Magick::Draw.new
  inside_rx = SIZE/2*0.85
  inside_ry = SIZE/2*0.85
  dr2.fill = inside_color
  dr2.ellipse(cx,cy,inside_rx,inside_ry,0,360)
  dr2.draw(img)

  # 文字を書く
  draw = Magick::Draw.new
  draw.annotate(img, 0, 0, 5, 5, str) do
    self.font      = FONT
    self.fill      = str_color
    self.stroke    = 'transparent'
    self.pointsize = point_size
    self.gravity   = Magick::CenterGravity
  end

  img.write(output_file_name)
end

# main
str = "パコ"
filename = 'pako.png'
outside_color = "#000000"
# パコる君の色
inside_color = "#F9BB33"
# メモニキの色
#inside_color = "#FC9827"
str_color = "#000000"

create(str, filename, outside_color, inside_color, str_color)
