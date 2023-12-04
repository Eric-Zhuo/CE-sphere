%直线L[A1;B1;D1]和椭圆[a1 b1 c1 d1 e1 1]'的交点
function [X,Y]=crossLandC(L,C)
A1=L(1);
B1=L(2);
D1=L(3);

C=C/C(3,3);
a1=C(1,1);
b1=2*C(1,2);
c1=C(2,2);
d1=2*C(1,3);
e1=2*C(2,3);

X=zeros(2,1);
Y=zeros(2,1);
%sovle算的
X(1)=-(D1 + (B1*(A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1^2*conj(e1) + A1*B1*conj(d1) + A1*D1*conj(b1) - 2*B1*D1*conj(a1)))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2)))/A1;

X(2)=-(D1 - (B1*(A1^2*conj(e1) + A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1*B1*conj(d1) - A1*D1*conj(b1) + 2*B1*D1*conj(a1)))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2)))/A1;

Y(1)=(A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1^2*conj(e1) + A1*B1*conj(d1) + A1*D1*conj(b1) - 2*B1*D1*conj(a1))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2));

Y(2)=-(A1^2*conj(e1) + A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1*B1*conj(d1) - A1*D1*conj(b1) + 2*B1*D1*conj(a1))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2));

end