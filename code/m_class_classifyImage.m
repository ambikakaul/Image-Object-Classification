% run vl_setup, check vlfeat version and load pkg image
setup ;

% load training data
pstv_train = load('data/Leopards_train_hist.mat') ;
ngtv_train = load('data/airplanes_train_hist.mat') ;

training_names = {pstv_train.names{:}, ngtv_train.names{:}}; % row matrix

% training_labels is a row matrix. pstv training set is assigned +1
% and ngtv training set is assigned -1
training_labels = [ones(1,numel(pstv_train.names)), - ones(1,numel(ngtv_train.names))] ;

histograms = [pstv_train.histograms, ngtv_train.histograms] ;

% select part of the training set first
% fraction = .1 ;
fraction = +inf ;

select_training = vl_colsubset(1:numel(training_labels), fraction, 'uniform') ;
histograms = histograms(:,select_training) ;
training_labels = training_labels(:,select_training) ;

% load testing data
pstv_test = load('data/Leopards_val_hist.mat') ;
ngtv_test = load('data/airplanes_val_hist.mat') ;
%one_test == load('data/

test_names = {pstv_test.names{:}, ngtv_test.names{:}};

test_labels = [ones(1,numel(pstv_test.names)), - ones(1,numel(ngtv_test.names))];

test_histograms = [pstv_test.histograms, ngtv_test.histograms] ;

% L2 normalize training and testing histograms before passing
% it to linear SVM
%histograms = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1))) ;
%test_histograms = bsxfun(@times, test_histograms, 1./sqrt(sum(test_histograms.^2,1))) ;


% training linear SVM

C = 100 ;
[w, bias] = trainLinearSVM(histograms, training_labels, C) ;

w = [w;bias];
% size(w)
% size(bias)

% calculate scores of the training data
training_scores = w' * histograms + bias ;




