tol=1e-6;
f=@(x) exp(x)-x^2+3*x-2;
fprintf("aralik yarilama icin,\n");
a=input("araligin sol siniri: ");
b=input("araligin sag siniri: ");
a0=a;
b0=b;
n=0;

if f(a)*f(b)>0
    fprintf("bu aralikta bir kok mevcut degil\n");

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
    fprintf("%d iterasyon sayisi\n", n);
    fprintf("%d ondalik basamak dogruluk icin gereken minimum iterasyon sayisi %d\n", -log10(tol), ceil(log2(abs(b0-a0)/tol)));

end




