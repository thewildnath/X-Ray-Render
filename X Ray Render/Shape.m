classdef Shape
    
    methods (Static)
        function out = AddSphere (mat, centerX, centerY, centerZ, r, value)
            [H, W, T] = size (mat);
            out = mat;

            for y = max (1, centerY - r + 1) : min (H, centerY + r + 1)
                for x = max (1, centerX - r + 1) : min (W, centerX + r - 1)
                    for z = max (1, centerZ - r + 1) : min (T, centerZ + r + 1)
                        if norm ([centerY - y, centerX - x, centerZ - z]) <= r
                            out (y, x, z) = out (y, x, z) + value;
                        end
                    end
                end
            end
        end
    
        function out = AddCylinder (mat, centerX, centerY, centerZ, r, height, value)
            [H, W, T] = size (mat);
            out = mat;

            for y = max (1, centerY - height/2 + 1) : min (H, centerY + height/2 + 1)
                for x = max (1, centerX - r + 1) : min (W, centerX + r - 1)
                    for z = max (1, centerZ - r + 1) : min (T, centerZ + r + 1)
                        if norm ([centerX - x, centerZ - z]) <= r
                            out (y, x, z) = out (y, x, z) + value;
                        end
                    end
                end
            end
        end
        
        function out = AddCube (mat, X, Y, Z, length, value)
            [H, W, T] = size (mat);
            out = mat;
            
            for y = max (1, Y - length/2) : min (Y + length/2, H)
                for x = max (1, X - length/2) : min (X + length/2, W)
                    for z = max (1, Z - length/2) : min (Z + length/2, T)
                        out (y, x, z) = out (y, x, z) + value;
                    end
                end
            end
        end
    end
end