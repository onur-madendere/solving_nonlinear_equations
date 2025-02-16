tol=1e-6;
f=@(x) cos(x)-x*exp(x);
fprintf("regula falsi icin,\n");
a=input("araligin sol siniri: ");
b=input("araligin sag siniri: ");
n=0;
max_num=10000000;

if f(a)*f(b)>0
    fprintf("bu aralikta bir kok yoktur\n");
    
elseif f(a)*f(b)==0
    if f(a)==0
        fprintf("kok %5.6f\n",a);
    end
    if f(b)==0
        fprintf("kok %5.6f\n",b);
    end
else
    while 1
        n=n+1;
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
        if abs(a-b)<tol || n>=max_num %bir sinirda takilabilir, 'sonsuz' dongu
            fprintf("%5.6f kok\n",m);
            break;
        end    
    end
    fprintf("iterasyon sayisi %d\n",n);
end
