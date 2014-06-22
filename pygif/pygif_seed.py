from images2gif import writeGif
from PIL import Image
from Colors import Colors 
from itertools import product
from random import choice
from os import remove, system
import base64
import json
import redis

for q in range(100):
   images=[]
   sequences = list(product(['y', 'b', 'g', 'r', 'p'], repeat=4))
   sequence = choice(sequences)
   sequence_str = ''.join(i for i in sequence)

   for i in sequence:
      i = sequence.index(i)
      ok = Colors(500,100)
      ok.drawCells()
      im = ok.img.convert("P")
      images.append(im)
      ok = Colors(500,100)
      ok.drawCells()
      ok.drawCell(i, 'active')
      im = ok.img.convert("P")
      images.append(im)


   ok = Colors(500,100)
   ok.drawCells()
   im = ok.img.convert("P")
   images.append(im)

   writeGif(sequence_str+".gif", images, duration=0.5, repeat=False)

   system("convert %s -colors 10 %s" % (sequence_str+".gif", sequence_str+".gif"))
   with open(sequence_str+".gif", "rb") as image_file:
      encoded_string = base64.b64encode(image_file.read())

   remove(sequence_str+".gif")

   json_data = json.dumps({'gif' : encoded_string, 'sequence' : sequence_str})

   print json_data
   r = redis.StrictRedis(host='localhost', port=6379, db=0)


   r.rpush('gifs', json_data)
