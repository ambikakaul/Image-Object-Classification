import os, sys, PIL
from PIL import Image

size = 128, 128
l=[]
sumx=0
sumy=0
count=0
minx=1000
miny=1000

folder_name = sys.argv[1]
#print folder_name
for subdir, dirs, files in os.walk(folder_name):
    files = [f for f in files if not f[0] == '.']
    #dirs[:] = [d for d in dirs if not d[0] == '.']
    for file in files:
        fullpath = os.path.join(subdir,file)
        count+=1
        #print os.path.join(subdir,file)
        im = Image.open(fullpath)
        (x,y) = im.size
        sumx = sumx + x
        sumy = sumy + y
        if(x < minx):
            minx = x
        if(y < miny):
            miny = y

avgx = sumx/count #279
avgy = sumy/count #249
#print("x:{0},y:{1}").format(avgx,avgy)
#print("x:{0},y:{1}").format(minx,miny)
#print("count:{0}").format(count)
nameGap = 40
dest_folder = sys.argv[2]
#print dest_folder
count = 0
filecount = -1
namecount = 0
for subdir, dirs, files in os.walk(folder_name):
    files = [f for f in files if not f[0] == '.']
    #print os.path.basename(subdir)
    if(os.path.basename(subdir) != "testing_samples"):
        txtfilename = dest_folder + '/data/' + os.path.basename(subdir) + '_val.txt'
        txtfile = open(txtfilename,'w+')
    
    filecount+=1
    for file in files:
        namecount = filecount
        
        #print("filecout:", filecount)
        #print("count:",count)
            #if(count == 1 or count%41 == 0 ):
            #namecount = filecount
            #else:
        namecount = filecount + (count % 40) * 50
        count+=1
        #print('namecount:',namecount)
        fullpath = os.path.join(subdir,file)
        
        im = Image.open(fullpath)
        im = im.resize((avgx,avgy), PIL.Image.ANTIALIAS)
        # For training code
        #txtfile.write('00' + str(namecount))
        #txtfile.write("\n")
        #dest_file = dest_folder + '/data/images/00' + str(namecount) + '.jpg'
        #print dest_file
        
        #for testing code
        txtfile.write('100' + str(count))
        txtfile.write("\n")
        dest_file = dest_folder + '/data/images/100' + str(count) + '.jpg'
        im.save(dest_file)

#txtfile.close()
#python size.py ./training_samples ./training_mixed