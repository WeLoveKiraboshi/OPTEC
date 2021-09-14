function D=distance_segment_circle(A,B,C,n,show)

for i=0:n
    M = A + (i/n)*(B-A);
    d(i+1) = norm(M-C);
    if show
        mess = "M=(" + M(1) + ","+M(2) + ") distance=" + d(i+1);
        disp(mess);
    end
end
D = min(d);

end

