% Camera Calibration Using Sphere Images
% Inputs:
%    Ci - Sphere image (at least 3)
%
% Outputs:
%    K - 3-by-3 - Intrinsic parameters
%

function [est_T_K] = T(sphere_image)
    %%
    %Method T needs at least 3 sphere images to calibration
    [~, ~, Image_num] = size(sphere_image);
    
    if Image_num < 3
        error('Method T needs at least 3 sphere images to calibration.')
    end
    
    %%
    %Step 1, find vertices%

    
    l = zeros(3, Image_num);
    
    for i = 1:Image_num
        Vi = zeros(3, Image_num);
        
        for j = 1:Image_num
            if i ~= j
         
                [Vij, e] = eig(sphere_image(:,:,i), sphere_image(:,:,j));
                e = diag(e);
                [~, k1] = max(abs(median(sign(e)) - sign(e))); 
                v = Vij(:, k1); 
                Vi(:, i) = v / v(3); %get the vanishing points
             end        
         end
         
         Vi(:, i) = [];

         [~,~,V] = svd(Vi'); 
         li = V(:,end);        
         l(:, i) = li / li(end);
         
     end


    %%
    %Step 2, obtain the simplified ICPs%

    %
    %Function, find the intersections between line L[A1;B1;D1] and conic C=[a1 b1 c1 d1 e1 1]'%

    function [X,Y] = crossLandC(L,C)
    A1 = L(1);
    B1 = L(2);
    D1 = L(3);

    C = C/C(3,3);
    a1 = C(1,1);
    b1 = 2*C(1,2);
    c1 = C(2,2);
    d1 = 2*C(1,3);
    e1 = 2*C(2,3);

    X = zeros(2,1);
    Y = zeros(2,1);
    %sovle
    X(1) = -(D1 + (B1*(A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1^2*conj(e1) + A1*B1*conj(d1) + A1*D1*conj(b1) - 2*B1*D1*conj(a1)))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2)))/A1;

    X(2) = -(D1 - (B1*(A1^2*conj(e1) + A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1*B1*conj(d1) - A1*D1*conj(b1) + 2*B1*D1*conj(a1)))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2)))/A1;

    Y(1) = (A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1^2*conj(e1) + A1*B1*conj(d1) + A1*D1*conj(b1) - 2*B1*D1*conj(a1))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2));

    Y(2) = -(A1^2*conj(e1) + A1*(A1^2*conj(e1)^2 + B1^2*conj(d1)^2 + D1^2*conj(b1)^2 - 4*B1^2*conj(a1) - 4*A1^2*conj(c1) - 4*D1^2*conj(a1)*conj(c1) + 4*A1*B1*conj(b1) - 2*A1*B1*conj(d1)*conj(e1) - 2*A1*D1*conj(b1)*conj(e1) + 4*A1*D1*conj(c1)*conj(d1) + 4*B1*D1*conj(a1)*conj(e1) - 2*B1*D1*conj(b1)*conj(d1))^(1/2) - A1*B1*conj(d1) - A1*D1*conj(b1) + 2*B1*D1*conj(a1))/(2*(conj(c1)*A1^2 - conj(b1)*A1*B1 + conj(a1)*B1^2));

    end

    mi = [];
    mj = [];

    for i = 1:Image_num
        [X,Y] = crossLandC(l(:, i), sphere_image(:,:,i));
        mi(:,i) = [X(1) Y(1) 1]';
        mj(:,i) = [X(2) Y(2) 1]';    
    end
    

    %%
    %Step 3, obtain the intrinsic and mirror parameters%

    A = [];
    for i = 1:Image_num
        A = [A;real(mi(1,i)^2) real(mi(1,i)*mi(2,i)) real(mi(2,i)^2) real(mi(1,i)) real(mi(2,i)) 1;
            imag(mi(1,i)^2) imag(mi(1,i)*mi(2,i)) imag(mi(2,i)^2) imag(mi(1,i)) imag(mi(2,i)) 0];
    end
    
    
    [~,~,V] = svd(A); 
    c = V(:,end);
    c = c/c(6);
    C = [c(1)   c(2)/2 c(4)/2;
       c(2)/2 c(3)   c(5)/2;
       c(4)/2 c(5)/2 c(6)  ];
    K1 = inv(chol(C));
    est_T_K = K1/K1(3,3); % get K
    

end


