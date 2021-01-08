function [RP, RESULTS, PARAMETERS]= GmdRQA(DATA,EMB,DEL,norm,perc,ZSCORE)

%  computes a recurrence plot for a multi-dimensional time-series and
%  performs recurrence quantification:
%    [RP, RESULTS, PARAMETERS]=mdrqa(DATA,EMB,DEL,PERC,ZSCORE,metric)
%
%
% Inputs:
%
%  DATA is a double-variable with each dimension of the to-be-analyzed
%  signal as a row of numbers in a separate column.
%
%  EMB is the number of embedding dimensions (i.e., EMB = 1 would be no
%  embedding via time-delayed surrogates, just using the provided number of
%  colums as dimensions.
%  The default value is EMB = 1.
%
%  DEL is the delay parameter used for time-delayed embedding (if EMB > 1).
%  The default value is DEL = 1.
%
%  RAD is the threhold/radius size within points in phase-space are counted
%  as being recurrent.
%
%  ZSCORE indicats, whether the data (i.e., the different columns of DATA,
%  being the different signals or dimensions of a signal) should be z-scored
%  before performing MdRQA:
%    0 - no z-scoring of DATA
%    1 - z-score columns of DATA
%  The default value is ZSCORE = 0.
%
%
% Outputs:
%
%  RP is a matrix holding the resulting recurrence plot.
%
%  RESULTS is a double-variable holding the following recurrence variables:
%    1.  Size of the RP
%    2.  %REC  - percentage of recurrent points
%    3.  %DET  - percentage of diagonally adjacent recurrent points
%    4.  MeanL - average length of adjacent recurrent points
%    5.  MaxL  - maximum length of diagonally adjacent recurrent points
%    6.  EntrL - Shannon entropy of distribution of diagonal lines
%    7.  %LAM  - percentage of vertically adjacent recurrent points
%    8.  MeanV - average length of diagonally adjacent recurrent points
%    9.  MaxV  - maximum length of vertically adjacent recurrent points
%    10. EntrV - Shannon entropy of distribution of vertical lines
%
%  PARAMETERS is a cell-variable holding the employed parameter settings:
%    1. DIM
%    2. EMB
%    3. DEL
%    4. RAD
%    5. NORM
%    6. ZSCORE
%

if exist('DATA') % check whether input data has been specified - if not, throw error message
else
    error('No input data specified.');
end

if exist('EMB') % check whether EMB has been specified - if not, set EMB = 1 (no surrogate embedding)
else
    EMB=1;
end

if exist('DEL') % check whether DEL has been specified - if not, set DEL = 1 (no delaying)
else
    DEL=1;
end

if size(DATA,1)>size(DATA,2)
    DATA = DATA';
end

if exist('ZSCORE') % check whether ZSCORE has been specified - if not, don't zscore
    if ZSCORE == 0
    else
        DATA=zscore(DATA);
    end
else
end

tempDIM=size(DATA); % calculate dimensionality of input time-series
DIM=tempDIM;

if EMB > 1 % if EMB > 1, perform time-delayed embbedding
    for i = 1:EMB
        tempDATA(1:length(DATA)-(EMB-1)*DEL,1+DIM*(i-1):DIM*i)=DATA(:,1+(i-1)*DEL:length(DATA)-(EMB-i)*DEL)';
    end
    %     clear DATA
    DATA=tempDATA;
    clear tempDATA
else
end

if strcmp('euc',norm) == 1
    a=pdist2(DATA,DATA);
elseif strcmp('min',norm) == 1
    for i = 1:length(DATA)
        for j = 1:length(DATA)
            dist = DATA(i,:)-DATA(j,:);
            a(i,j) = min(abs(dist));
        end
    end
elseif strcmp('max',norm) == 1
    for i = 1:length(DATA)
        for j = 1:length(DATA)
            dist = DATA(i,:)-DATA(j,:);
            a(i,j) = max(abs(dist));
        end
    end
elseif strcmp('frob',norm) == 1
    a = distance_metric(DATA,'frob',EMB,DIM(1));
end

a_rp = zeros(size(a));

dists = a(:);
uu = sort(dists);

if isempty(uu)==0 && uu(ceil(perc*length(uu))) >0
    RAD = uu(ceil(perc*length(uu)));
else
    RAD = 0;
end

a_rp(a<RAD) = 1;
a = a_rp;

%%%%%%%%%%%%%%%%%% Recurrence Quantification Measures %%%%%%%%%%%%%%%%%%%%

if sum(sum(a)) > 0
    diag_hist=[];
    vertical_hist=[];
    for i = -(length(DATA)-1):length(DATA)-1 % caluculate diagonal line distribution
        c=diag(a,i);
        if isempty(c)== 1
        else
            d=bwlabel(c,8);
            d=tabulate(d);
            if d(1,1)==0
                d=d(2:end,2);
            else
                d=d(2);
            end
            diag_hist(length(diag_hist)+1:length(diag_hist)+length(d))=d;
        end
    end
    diag_hist=diag_hist(diag_hist<max(diag_hist));
    
    if isempty(diag_hist)
        diag_hist=0;
    else
    end
    
    out = a - diag(diag(a));
    for i=1:size(a,2) % calculate vertical line distribution
        c=(out(:,i));
        v=bwlabel(c,8);
        v=tabulate(v);
        if v(1,1)==0
            v=v(2:end,2);
        else
            v=v(2);
        end
        vertical_hist(length(vertical_hist)+1:length(vertical_hist)+length(v))=v;
    end
    
    RESULTS(1,1)=length(a); % calculate recurrence variables
    RESULTS(1,2)=(sum(sum(a))-length(a))/(length(DATA)^2);
    if RESULTS(1,2) > 0
        RESULTS(1,3)=sum(diag_hist(diag_hist>1))/sum(diag_hist);
        if isempty(diag_hist(diag_hist>1))
            RESULTS(1,4) = 0;
        else
            RESULTS(1,4)=mean(diag_hist(diag_hist>1));
        end
        RESULTS(1,5)=max(diag_hist);
        [count,~]=hist(diag_hist(diag_hist>1),min(diag_hist(diag_hist>1)):max(diag_hist));
        total=sum(count);
        p=count./total;
        del=find(count==0); p(del)=[];
        RESULTS(1,6)=-1*sum(p.*log(p));
        RESULTS(1,7)=sum(vertical_hist(vertical_hist>1))/sum(vertical_hist);
        RESULTS(1,8)=mean(vertical_hist(vertical_hist>1));
        RESULTS(1,9)=max(vertical_hist);
        [count,~]=hist(vertical_hist(vertical_hist>1),min(vertical_hist(vertical_hist>1)):max(vertical_hist));
        total=sum(count);
        p=count./total;
        del=find(count==0); p(del)=[];
        RESULTS(1,10)=-1*sum(p.*log(p));
    else
        RESULTS(1,3:10)=NaN;
    end
else
    RESULTS(1,3:10)=NaN;
end
RP=imrotate(a,90); % format recurrence plot

PARAMETERS={DIM,EMB,DEL,ZSCORE};
end