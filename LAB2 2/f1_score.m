function [F1] = f1_score(yHaT,yval)
%F1_SCORE Summary of this function goes here
%   Detailed explanation goes here
tp = sum((yHaT == 1) & (yval == 1));
fp = sum((yHaT == 1) & (yval == -1));
fn = sum((yHaT == -1) & (yval == 1));

precision = tp / (tp + fp);
recall = tp / (tp + fn);
F1 = (2 * precision * recall) / (precision + recall);
end

