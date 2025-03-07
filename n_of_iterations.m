tol=1e-6;
num_arr(5)=0;
num_arr(:)=inf;
syms x f df
f=x^2-3*x-1;
df=diff(f);
f=matlabFunction(f);
df=matlabFunction(df);

syms x g1 dg1
g1=(x^2-1)/3;
dg1=diff(g1);
g=matlabFunction(g1);
dg=matlabFunction(dg1);


a=input("sol sinir: ");
b=input("sag sinir: ");

fprintf("aralik yarilama icin,\n");
a0=a;
b0=b;
n_arm=0;

if f(a)*f(b)>0
    fprintf("bu aralikta bir kok mevcut degil\n");

elseif f(a)*f(b)==0
        if f(a)==0
            fprintf("kok %5.6f\n",a);
            num_arr(1)=n_arm;
        end
        if f(b)==0
            fprintf("kok %5.6f\n",b);
            num_arr(1)=n_arm;
        end

else
    while 1
        n_arm=n_arm+1;
        m=(a+b)/2;
        if f(m)*f(a)<0
            b=m;
       
        elseif f(m)*f(b)<0
            a=m;
        end

        if f(m)==0
            fprintf("kok %5.6f",m);
            break;
        end
       
        if abs(a-b)<tol
            fprintf("%5.6f kok\n", m);
            break;
        end      
    end
    num_arr(1)=n_arm;

end

fprintf("\n");
%%%

fprintf("regula falsi icin,\n");
a=a0;
b=b0;
n_rfm=0;
max_num=10000000;

if f(a)*f(b)>0
    fprintf("bu aralikta bir kok yoktur\n");
    
elseif f(a)*f(b)==0
    if f(a)==0
        fprintf("kok %5.6f\n",a);
        num_arr(2)=n_rfm;
    end
    if f(b)==0
        fprintf("kok %5.6f\n",b);
        num_arr(2)=n_rfm;
    end
else
    while 1
        n_rfm=n_rfm+1;
        m=(f(b)*a-f(a)*b)/(f(b)-f(a));

        if f(a)*f(m)<0
            b=m;
        elseif f(b)*f(m)<0
            a=m;
        end
        
        if f(m)==0
            fprintf("kok %5.6f\n",m);
            break;
        end
        if abs(a-b)<tol || n_rfm>=max_num 
            fprintf("%5.6f kok\n",m);
            break;
        end    
    end
    num_arr(2)=n_rfm;
    fprintf("\n");
end

%%% 

flag0=0;
flag1=0;

fprintf("sabit nokta icin,\n");
a=a0;
b=b0;

maksg=@(x) -g(x);
if g(fminbnd(g,a,b))>=a && g(fminbnd(maksg, a,b))<=b 
    flag0=1;
    fprintf("fonksiyonun bu aralikta sabit noktasi var\n");
else
    fprintf("sabit noktasi yok, yontem uygulanamaz\n")
end

maksdg=@(x) -dg(x);
if flag0==1 && abs(dg(fminbnd(dg,a,b)))<1 && abs(dg(fminbnd(maksdg,a,b)))<1 
    flag1=1;
    fprintf("fonksiyonun bu aralikta sabit noktasi bir tane\n");
elseif flag0==1
    fprintf("sabit noktasi bir tane degil\n");
end

if flag0==1 && flag1==1
    x0=input("sni icin x0 baslangic noktasi girin: ");
    n_sni=0;
    max_num=100000;
    cur=x0;
    temp=0;
    while 1
        n_sni=n_sni+1;
        next=g(cur);
        temp=cur;
        cur=next;
        if abs(cur-temp)<tol || n_sni>=max_num
            break;
        end
    end
    fprintf("sabit nokta %5.6f\n", cur);
    num_arr(3)=n_sni;

end
fprintf("\n");
%%%

n_n_r=0;
fprintf("newton raphson icin,\n");
x0=input("bir baslangic noktasi secin: ");

if f(x0)==0
    fprintf("kok %5.6f\n",x0);
end

cur=x0;
next=0;
temp=0;

while 1
    n_n_r=n_n_r+1;
    next=cur-f(cur)/df(cur);
    temp=cur;
    cur=next;
    if abs(next-temp)<tol || n_n_r>=max_num
        break;
    end
end
fprintf("kok %5.6f\n", cur);
num_arr(4)=n_n_r;
fprintf("\n");

%%%

fprintf("secant icin,\n");
x0=input("bir x0 noktasi girin: ");
x1=input("bir x1 noktasi girin: ");

n_sec=1;
temp1=0;
cur0=x0;
cur1=x1;

while 1
    n_sec=n_sec+1;
    next=cur1-f(cur1)*(cur1-cur0)/(f(cur1)-f(cur0));
    temp1=cur1;
    cur0=cur1;
    cur1=next;
    if abs(next-temp1)<tol
        break;
    end
end

fprintf("kok %5.6f\n", cur1);

num_arr(5)=n_sec;
name_arr=["arm: ", "rfm: ", "sni: ", "n-r: ", "secant: "];
c={num_arr,name_arr};

%fprintf("%s %d\n", [c{2}(:);c{1}(:)]); veya dongusuz herhangi baska yazim
%ozellikle isnan ile

for i=1:5
    if num_arr(i)<=max_num
        fprintf("%s%d\n", name_arr(i),num_arr(i));
    else
        fprintf("sonuclari kontrol et\n");
        continue;
    end
end