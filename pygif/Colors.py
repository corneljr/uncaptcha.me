from PIL import Image
class Colors():

    def __init__(self, x=None, y=None, bg=None, padding=0):
        if x == None or y == None:
            self.img = Image.new( 'RGBA', (500, 100), "white")
        elif bg == None:
             self.img = Image.new( 'RGBA', (x, y), "white")
        else:
            self.img = Image.new( 'RGBA', (x, y), bg)

        self.x = x
        self.y = y
        self.padding = padding
	self.cells = [
            {'color' : 'blue', 'active' : "#40a6ff", 'inactive' : "#99cfff"},
            {'color' : 'yellow', 'active' : "#ffec40", 'inactive' : "#fff599"},
            {'color' : 'red', 'active' : "#ff5040", 'inactive' : "#ffa299"},
            {'color' : 'purple', 'active' : "#af40ff", 'inactive' : "#d599ff"},
            {'color' : 'green', 'active' : "#80ff40", 'inactive' : "#bbff99"}
        ]

        for i in range(len(self.cells)):
            for j in ['active', 'inactive']:
                self.cells[i][j] = self.hex_to_rgb(self.cells[i][j])

        self.pixels = self.img.load()
    
    def hex_to_rgb(self,value):
        value = value.lstrip('#')
        lv = len(value)
        return tuple(int(value[i:i+lv/3], 16) for i in range(0, lv, lv/3))


    def drawSquare(self, x1, y1, x2, y2, color):
        for i in range(x1,x2):
            for j in range(y1, y2):
                self.pixels[i,j] = color
 
    def drawCells(self):
	for i in range(len(self.cells)):
            self.drawCell(i,'inactive')

    def drawCell(self, cell, state):
        self.drawSquare((self.x/len(self.cells)*cell)+self.padding,
                self.padding,
                (self.x/len(self.cells)*cell)+self.x/len(self.cells)-self.padding,
                self.y-self.padding,
                        self.cells[cell][state]
                )



