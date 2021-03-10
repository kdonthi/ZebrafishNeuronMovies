# ZebrafishNeuronMovies

This folder consists of programs that utilize zebrafish calcium imaging data to create movies and 3D images of firing over time and space. <br/>

The goal of these programs is not to just plot these neurons, but to create custom sliding windows to reduce the amount of data you see. Additionally, the ```deltaFoF``` value is a measure of the calcium concentration over a baseline value.<br/>


The arguments for these files include: <br/>
  a) ```Windowsize``` - the amount of indices you want to include in each window of time; the deltaFoF values will be thresholded and then averaged to plot this period of time <br/>
  b) ```Spacing``` - the index distance between the starting indices of each of the windows (i.e. a spacing of 1 means that windows will start from indices 1,2,3,... while a spacing of 2 means that windows will start from 1,3,5,...)<br/>
  c) ```Threshold``` - we say a neuron is firing if it has a deltaFoF > threshold and and not firing if deltaFoF <= threshold<br/>
  d) ```freq``` - frames per second (the actual recording happened at 7 Hz, so putting a 7 here would be "real time")<br/><br/>
Unfortunately, one of the data files needed to create the movies is too big to fit on Github, so please enjoy the movies I have already made. If you want to look at the code, the 3 main functions are: <br/>
  a) ```movie.m``` - which creates a single movie with 2 chosen clusters side by side, or 1 chosen cluster and 1 cluster of randomly chosen neurons of the same size. (There is an optional argument.) <br/>
  b) ```subplotfunc.m``` - creates side by side movies of the first 12 chosen clusters, the colored neurons are the neurons firing and in the cluster and the grey neurons are the neurons firing and not in the cluster<br/>
  c) ```visualization.m``` - creates a 3D plot of the neuron firing over time and space <br/>
  
 The ```.mp4``` files that have ```Subplots: ``` at the begining are the ones created by ```subplotfunc.m``` and the ones that have cluster numbers and colors, i.e. "1 is RED and 2 is GREEN" are created by ```movie.m```. <br/>
 
 Enjoy!
