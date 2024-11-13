%% Generate Random Sphere Image
% Inputs:
%    Image_num - Sphere image number
%    X - 3-by-3 - Intrinsic parameters
%    Rad - 1-by-Image_num - Radii of sphere
%    K - 3-by-3 - Intrinsic parameters
%    R - 3-by-3-by-Image_num - Rotations
%    T - 3-by-Image_num - Translations
%
% Outputs:
%    sphere_image - 3-by-3-by-Image_num - Sphere images

function [sphere_image] = generate_sphere_image(Image_num, X, Rad, K, R, T)

  sphere_image = zeros(3, 3, Image_num);
  
  for i = 1:Image_num     

      x = X(:, i);
      rad = Rad(i);
      r = R(:, :, i);
      t = T(:, i);

      Q = [1 0 0 -x(1);
           0 1 0 -x(2);
           0 0 1 -x(3);
           -x(1) -x(2) -x(3) x(1)^2+x(2)^2+x(3)^2-rad^2];
      H = K*[r t];
      Q1 = H*inv(Q)*H';
      C = inv(Q1);  
      C = C/C(3,3);

      sphere_image(:,:,i) = C;
      
  end
  
end
