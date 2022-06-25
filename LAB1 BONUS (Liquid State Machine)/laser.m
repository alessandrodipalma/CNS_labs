load laser_dataset
data = cell2mat(laserTargets);
input = data(1:end-1);
target = data(2:end);

tr_input = input(1:1500);
ts_input = input(1500+1:2000);
tr_target = target(1:1500);
ts_target = target(1500+1:2000);

modified(input);


