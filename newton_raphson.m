syms x f df
f=x-1.2*sin(x)-0.5;
df=diff(f);
f=matlabFunction(f);
df=matlabFunction(df);


tol=1e-6;
n=0;
max_n=100000;
fprintf("newton raphson icin,\n");
x0=input("bir baslangic noktasi secin: ");

if f(x0)==0
    fprintf("kok %5.6f\n",x0);
end

cur=x0;
next=0;
temp=0;

while 1
    n=n+1;
    next=cur-f(cur)/df(cur);
    temp=cur;
    cur=next;
    if abs(next-temp)<tol || n>=max_n
        break;
    end
end
fprintf("iterasyon sayisi %d\n", n);
fprintf("kok %5.6f", cur);




    
