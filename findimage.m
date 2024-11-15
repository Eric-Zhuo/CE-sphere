%找圆像%
%输入球心坐标X，球半径r，想获得的点的数目n，n为偶数%
%默认光心坐标为[0;0;0]%
%输出C为圆像的矩阵，c为C的向量形式%
%x1为圆像的圆心%
function [C,c,x1] =findimage(X,r,K,R,T)
Q=[1 0 0 -X(1);
   0 1 0 -X(2);
   0 0 1 -X(3);
   -X(1) -X(2) -X(3) X(1)^2+X(2)^2+X(3)^2-r^2];
H=K*[R T];
Q1=H*inv(Q)*H';
C=inv(Q1);
c=[C(1,1) 2*C(1,2) C(2,2) 2*C(1,3) 2*C(2,3) C(3,3)]';
c=c/C(3,3);

x1=H*[X;1];
x1=x1/x1(3);

end