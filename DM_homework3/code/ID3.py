import math
import sys

def myfun(x1, x2):
    x3 = x1+x2
    res = -x1/x3*math.log(x1/x3,2)-x2/x3*math.log(x2/x3,2)
    return res

if(len(sys.argv)>=4):
    a = int(sys.argv[1])
    b = int(sys.argv[2])
    c = int(sys.argv[3])
    d = int(sys.argv[4])

    sum1 = a+b
    sum2 = c+d

    res1 = myfun(a,b)
    res2 = myfun(c,d)
    res3 = sum1/(sum1+sum2)*res1+sum2/(sum1+sum2)*res2
    print(res1)
    print(res2)
    print(res3)
else:
    a = int(sys.argv[1])
    b = int(sys.argv[2])
    print(myfun(a,b))