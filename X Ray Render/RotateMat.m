function out = RotateMat (mat, rot)
    R = RotationMat (rot(1), rot(2), rot(3));
    RInv = RotationMat (-rot(1), -rot(2), -rot(3));
    
    [H, W, T] = size (mat);
    sMin = Inf (3, 1);
    sMax = -Inf (3, 1);
    
    for x = 1 : W-1 : W
        for y = 1 : H-1 : H
            for z = 1 : T-1 : T
                p = R * [x; y; z];
                
                sMin = min (sMin, p);
                sMax = max (sMax, p);
            end
        end
    end
    
    if sMin(1) <= 0
        sMin(1) = sMin(1) + 1;
    end
    if sMin(2) <= 0
        sMin(2) = sMin(2) + 1;
    end
    if sMin(3) <= 0
        sMin(3) = sMin(3) + 1;
    end
    
    HNew = round (sMin(2) + sMax(3) + 0.49);
    WNew = round (sMin(1) + sMax(3) + 0.49);
    TNew = round (sMin(3) + sMax(3) + 0.49);
    
    out = zeros (HNew, WNew, TNew);
    
    for y = 1 : HNew
        for x = 1 : WNew
            for z = 1 : TNew
                pNew = [x; y; z];
                p = round (RInv * pNew + 0.5);
                
                if p(1) >= 1 && p(2) >= 1 && p(3) >= 1 &&...
                   p(1) <= W && p(2) <= H && p(3) <= T
                    out(pNew(2), pNew(1), pNew(3)) = mat (p(2), p(1), p(3));
                end
            end
        end
    end
end