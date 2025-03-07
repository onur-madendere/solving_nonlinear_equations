tol=1e-6;
f=@(x) exp(x)+2^(-x)+2*cos(x)-6;

fprintf("secant icin,\n");
x0=input("bir x0 noktasi girin: ");
x1=input("bir x1 noktasi girin: ");
n=1;

temp1=0;
cur0=x0;
cur1=x1;

while 1
    n=n+1;
    next=cur1-f(cur1)*(cur1-cur0)/(f(cur1)-f(cur0));
    temp1=cur1;
    cur0=cur1;
    cur1=next;
    if abs(next-temp1)<tol
        break;
    end
end

fprintf("kok %5.6f\n", cur1);
fprintf("sekant iterasyon sayisi %d\n", n);
