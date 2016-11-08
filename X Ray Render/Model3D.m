classdef Model3D
    
    methods (Static)
        function mat = Cube (length, value)
            length = round (length);
            mat = ones (length, length, length) * value;
        end
        function mat = Sphere (radius, value)
            H = radius * 2;
            mat = zeros (H, H, H);
            
            for y = 1 : H
                for x = 1 : H
                    for z = 1 : H
                        if norm ([radius - x, radius - y, radius - z]) <= radius
                            mat (y, x, z) = value;
                        end
                    end
                end
            end
        end
    end
end