function R = RotationMat (rotX, rotY, rotZ)
    % Pitch
    RX = [1, 0, 0;...
          0, cos(rotX), sin(rotX);...
          0, -sin(rotX), cos(rotX)];
    % Yaw
    RY = [cos(rotY), 0, -sin(rotY);...
          0, 1, 0;...
          sin(rotY), 0, cos(rotY)];
    % Roll
    RZ = [cos(rotZ), sin(rotZ), 0;... 
          -sin(rotZ), cos(rotZ), 0;...
          0, 0, 1];
      
    % Roll Pitch Yaw
    R = RZ * RX * RY;
end