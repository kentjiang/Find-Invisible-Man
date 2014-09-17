clear;
VDD=[1 0.9 0.8 0.7 0.6 0.5 0.45 0.4 0.35];
E=[19.4 15.4 12.1 9.04 6.45 4.31 3.42 2.65 1.99];
tp_f=[21 24 27 33 43 63 83 119 186];
tp_t=[28 32 38 47 66 108 154 241 423];
tp_s=[36 42 51 67 99 182 279 480 922];
EDP_f=tp_f.*E;
EDP_t=tp_t.*E;
EDP_s=tp_s.*E;
plot(VDD,EDP_f,'b',VDD,EDP_t,'r',VDD,EDP_s,'g');

hold on;
x=VDD;
y=EDP_f;
x=x(y==min(min(y)))
y=min(y)
plot(x,y,'b.','Markersize',20);

hold on;
x=VDD;
y=EDP_t;
x=x(y==min(min(y)))
y=min(y)
plot(x,y,'r.','Markersize',20);

hold on;
x=VDD;
y=EDP_s;
x=x(y==min(min(y)))
y=min(y)
plot(x,y,'g.','Markersize',20);
legend('EDP_f','EDP_t','EDP_s','MinEDP_f (0.5,271.53)','MinDEP_t (0.7,424.88)','MinDEP_s (0.7 605.68)');
