classdef Camera
    
    properties 
        % Resolution
        resX = 1;
        resY = 1;
        % Size of the pixel in the world
        pixelXSize = 1;
        pixelYSize = 1;
        % Distance between emiter and capturing plane
        focalLength = 5;
        % Intensity of the x-ray
        intensity = 1;
        % Distance between measurements
        stepSize = 1;
        
        center = [1; 1; 1];
    end
    
    methods
        function P = CamMat (this)
            R = RotationMat (0, 0, 0);
            
            % Probably not good, needs testing
            K = [this.focalLength / this.pixelXSize, 0, (this.resX - 1) / 2 / this.pixelXSize;...
                0, this.focalLength / this.pixelYSize, (this.resY - 1) / 2 / this.pixelYSize;...
                0, 0, 1];
            
            P = [K * R,  -K * R * this.center];
        end
        
        function img = Render (this, mat, rot)
            img = ones (this.resY, this.resX) * this.intensity;
            
            mat = RotateMat (mat, rot);
            [H, W, T] = size (mat);
            corner = [-W/2; H/2; -T/2];
            
            height = -T/2;
            this.center = [0; 0; this.focalLength];
            
            for y = 1 : this.resY
                fprintf ('Row %i\n', y);
                for x = 1 : this.resX
                    pixelPos = [(x - this.resX / 2 - 0.5) * this.pixelXSize;...
                        (y - this.resY / 2 - 0.5) * this.pixelYSize;...
                        height];
                            
                    dir = pixelPos - this.center;
                    deltaPos = Normalize (dir) * this.stepSize;
                    startStep = max((T - this.center(3) - height) / deltaPos(3) - 1, 0);
                    endStep = -dir(3) / this.stepSize;
                    
                    pos = this.center + deltaPos * startStep;
                    for i = startStep : endStep
                        pos = pos + deltaPos;
                        
                        voxelPos = round (pos - corner + [0.5; -0.5; 0.5]);
                        if voxelPos(1) >= 1 && -voxelPos(2) >= 1 && voxelPos(3) >= 1 &&...
                          voxelPos(1) <= W && -voxelPos(2) <= H && voxelPos(3) <= T
                           coef = mat (-voxelPos(2), voxelPos(1), voxelPos(3));
                           img(y, x) = img(y, x) * exp (-coef * this.stepSize * 0.001);
                        end
                    end
                end
            end
            
            img = -img + this.intensity;
        end
%         function img = Render (this, mat)
%             img = zeros (this.resY, this.resX);
%             forward = [0; 0; -1];
%             endStep = round (this.focalLength / this.step);
%             [H, W, T] = size (mat);
%             voxelTick = this.step * 0.001;
%             
%             this.center = [W/2; -H/2; this.focalLength];
%             this.center = [0; 0; this.focalLength];
%             
%             lengthX = this.resX * this.pixSize;
%             lengthY = this.resY * this.pixSize;
%             
%             p1 = [W/2 - lengthX/2; -H/2 + lengthY/2; -5];
%             p2 = [W/2 + lengthX/2; -H/2 - lengthY/2; -5];
%             
%             for i = 1 : this.resY
%                 fprintf ('Row %i\n', i);
%                 for j = 1 : this.resX
%                     X = [(p1(1) * (this.resX - j) + p2(1) * j) / this.resX;...
%                          (p1(2) * (this.resY - i) + p2(2) * i) / this.resY;...
%                          0];
%                     dir = Normalize (X - this.center);
%                     if (dot (forward, dir)  < 0)
%                         dir = -dir;
%                     end
%                     deltaStep = dir * this.step;
%                     
%                     startStep = max((T - this.center(3)) / deltaStep(3) - 1, 0);
%                     
%                     rayIntensity = this.intensity;
%                     pos = this.center + deltaStep * startStep;
%                     
%                     for k = startStep : endStep
%                         pos = pos + deltaStep;
%                         
%                         coord = round (pos + 0.51);
%                         if coord(1) <= W && -coord(2) <= H && coord(3) <= T &&...
%                            coord(1) >= 1 && -coord(2) >= 1 && coord(3) >= 1
%                             coef = mat(-coord(2), coord(1), coord(3));
%                         else
%                             coef = 0;
%                         end
%                         
%                         rayIntensity = rayIntensity * exp (-coef * voxelTick);
%                     end
%                     
%                     img(i, j) = rayIntensity;
%                 end
%             end
%             
%             img = -img + this.intensity;
%         end
    end
    
end