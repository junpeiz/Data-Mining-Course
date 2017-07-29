load('TDT2_data', 'fea', 'gnd');

% YOUR CODE HERE
options = [];
options.NeighborMode = 'KNN';
options.k = 5;
options.WeightMode = 'Binary';
options.t = 1;
W = constructW(fea,options);

repeat = 100;
AC1 = 0.0;
MIhat1 = 0.0;
AC2 = 0.0;
MIhat2 = 0.0;
for i = 1:repeat
    idx=spectral(W,5);
    res=bestMap(gnd,idx);
    AC1 = AC1 + length(find(gnd == res))/length(gnd);
    MIhat1 = MIhat1 + MutualInfo(gnd,res);

    idx=litekmeans(fea,5);
    res=bestMap(gnd,idx);
    AC2 = AC2 + length(find(gnd == res))/length(gnd);
    MIhat2 = MIhat2 + MutualInfo(gnd,res);
end
AC1 = AC1/repeat;
MIhat1 = MIhat1/repeat;
AC2 = AC2/repeat;
MIhat2 = MIhat2/repeat;
fprintf('For the spectral clustering, the accuracy is %f and the normalized mutual information is %f\n', AC1, MIhat1);
fprintf('For the k-means clustering, the accuracy is %f and the normalized mutual information is %f\n', AC2, MIhat2);