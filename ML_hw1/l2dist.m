function [ result ] = l2dist(px, py)
%L2DIST Summary of this function goes here
%   Detailed explanation goes here

result = sqrt(sum((px-py).^2));

end

