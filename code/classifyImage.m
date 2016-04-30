% run vl_setup, check vlfeat version and load pkg image
setup ;

% load training data
pstv_train = load('data/minaret_train_hist.mat') ;
ngtv_train = load('data/butterfly_train_hist.mat') ;

training_names = {pstv_train.names{:}, ngtv_train.names{:}}; % row matrix

% training_labels is a row matrix. pstv training set is assigned +1
% and ngtv training set is assigned -1
training_labels = [ones(1,numel(pstv_train.names)), - ones(1,numel(ngtv_train.names))] ;

histograms = [pstv_train.histograms, ngtv_train.histograms] ;

% select part of the training set first
%fraction = .5 ;
fraction = +inf ;

select_training = vl_colsubset(1:numel(training_labels), fraction, 'uniform') ;
histograms = histograms(:,select_training) ;
training_labels = training_labels(:,select_training) ;

% load testing data
pstv_test = load('data/minaret_val_hist.mat') ;
ngtv_test = load('data/butterfly_val_hist.mat') ;

test_names = {pstv_test.names{:}, ngtv_test.names{:}};

test_labels = [ones(1,numel(pstv_test.names)), - ones(1,numel(ngtv_test.names))] ;

test_histograms = [pstv_test.histograms, ngtv_test.histograms] ;

% training linear SVM

C = 100 ;
[w, bias] = trainLinearSVM(histograms, training_labels, C) ;

w = [w;bias];
% size(w)
% size(bias)

% calculate scores of the training data
training_scores = w' * histograms + bias ;

% plot training images according to descending score
%figure(1) ; clf ; set(1,'name','Ranked training images (subset)') ;
%displayRankedImageList(training_names, training_scores)  ;

% plot the precision-recall curve
%figure(2) ; clf ; set(2,'name','Precision-recall on training data') ;
%vl_pr(training_labels, training_scores) ;


% classifying the test images and finding performance

% calculate scores for test images
test_scores = w' * test_histograms + bias ;
test_scores

% plot test images according to descending score
%figure(3) ; clf ; set(3,'name','Ranked test images (subset)') ;
%displayRankedImageList(test_names, test_scores)  ;

% plot the precision-recall curve
figure(1) ; clf ; set(1,'name',' Accuracy on test data') ;
vl_pr(test_labels, test_scores) ;

[drop,perm] = sort(test_scores,'descend') ;
fprintf('Correctly retrieved in the top 36: %d\n', sum(test_labels(perm(1:36)) > 0)) ;

