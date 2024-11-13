%% Generate Random Sphere Image
% Inputs:
%    Image_num - Sphere image number
%    K - 3-by-3 - Intrinsic parameters
%
% Outputs:
%    sphere_image - 3-by-3-by-Image_num - Sphere image

function [sphere_image] = generate_sphere_image(Image_num, K)

  sphere_image = zeros(3, 3, Image_num);
  
  for i = 1:Image_num
      x = normrnd(0,1,3,1);
      n = x/norm(x);
      d = 0;
      Q = [(l^2-1)*n(1)^2+(d+l*n(3))^2  (l^2-1)*n(1)*n(2)                -(l*d+n(3))*n(1);
          (l^2-1)*n(1)*n(2)               (l^2-1)*(n(2))^2+(d+l*n(3))^2   -(l*d+n(3))*n(2);
          -(l*d+n(3))*n(1)                -(l*d+n(3))*n(2)                 d^2-n(3)^2      ];
      C = inv(K')*Q*inv(K);
      C = C/C(3,3);

      sphere_image(:,:,i) = C;
  end
  
end
