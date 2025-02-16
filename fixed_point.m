syms x g1 dg1
g1=sqrt(2-sin(x));
dg1=diff(g1);
g=matlabFunction(g1);
dg=matlabFunction(dg1);

tol=1e-6;
flag0=0;
flag1=0;


tol=1e-6;
fprintf("sabit nokta icin,\n");
a=input("araligin sol siniri: ");
b=input("araligin sag siniri: ");

maksg=@(x) -g(x);
if fminbnd(g,a,b)>=a && fminbnd(maksg, a,b)<=b
    flag0=1;
    fprintf("fonksiyonun bu aralikta sabit noktasi var\n");
else
    fprintf("sabit noktasi yok, yontem uygulanamaz\n")
end

maksdg=@(x) -dg(x);
if flag0==1 && abs(fminbnd(dg,a,b))<1 && abs(fminbnd(maksdg,a,b))<1
    flag1=1;
    fprintf("fonksiyonun bu aralikta sabit noktasi bir tane\n");
else
    fprintf("sabit noktasi bir tane degil\n");
end


%flag0+flag1>=1, sabit nokta bir tane degilken de yapar
if flag0==1 && flag1==1
    x0=input("bir x0 baslangic noktasi girin: ");
    n=0;
    max_n=100000;
    cur=x0;
    temp=0;
    while 1
        n=n+1;
        next=g(cur);
        temp=cur;
        cur=next;
        if abs(cur-temp)<tol || n>=max_n
            break;
        end
    end
    fprintf("sabit nokta %5.6f\n", cur);
    fprintf("iterasyon sayisi %d",n);

end










